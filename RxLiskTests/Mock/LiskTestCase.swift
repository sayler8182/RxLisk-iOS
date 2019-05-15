//
//  LiskTest.swift
//  RxLiskTests
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import RxLisk

// MARK: LiskTestCase
class LiskTestCase: XCTestCase {
    let secret: String = "{type_here_your_secret_for_test}"
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // dispose bag
    override func setUp() {
        super.setUp()
        
        self.disposeBag = DisposeBag()
    }
    
    // block success request
    func blockSuccess<T>(_ single: Single<T>,
                         file: StaticString = #file,
                         line: UInt = #line) -> T! {
        let exp: XCTestExpectation = XCTestExpectation()
        var result: T!
        
        // block request
        single
            .do(onDispose: { exp.fulfill() })
            .subscribe(
                onSuccess: { (r) in result = r },
                onError: { (e) in XCTFail(e.localizedDescription) })
            .disposed(by: self.disposeBag)
        
        // wait
        self.wait(for: [exp], timeout: 10)
        return result
    }
    
    // block error request
    func blockError<T>(_ single: Single<T>,
                       file: StaticString = #file,
                       line: UInt = #line) -> LiskError! {
        let exp: XCTestExpectation = XCTestExpectation()
        var error: LiskError!
        
        // block request
        single
            .do(onDispose: { exp.fulfill() })
            .subscribe(
                onSuccess: { _ in XCTFail("Expected an error response") },
                onError: { (e) in error = e as? LiskError })
            .disposed(by: self.disposeBag)
        
        // wait
        self.wait(for: [exp], timeout: 10)
        return error
    }
}
