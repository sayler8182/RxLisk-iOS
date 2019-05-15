//
//  LiskDelegatesTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskDelegatesTests
class LiskDelegatesTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskDelegates {
        
        return LiskDelegates(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    } 
    
    /// test delegates
    func testDelegates() {
        let module: LiskDelegates = self.module()
        
        // delegates
        let delegates = module.delegates()
        let response = self.blockSuccess(delegates)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test delegates with username
    func testDelegates_Username() {
        let module: LiskDelegates = self.module()
        
        // delegates
        let delegates = module.delegates(username: "cc001")
        let response = self.blockSuccess(delegates)!
        
        // test
        XCTAssertEqual(response.data.count, 1)
    }
    
    /// test delegates with offset and limit
    func testDelegates_OffsetAndLimit() {
        let module: LiskDelegates = self.module()
        
        // delegates
        let delegates = module.delegates(offset: 20, limit: 5)
        let response = self.blockSuccess(delegates)!
        
        // test
        XCTAssertEqual(response.meta.offset, 20)
        XCTAssertEqual(response.meta.limit, 5)
        XCTAssertEqual(response.data.count, 5)
    }
    
    /// test delegate
    func testDelegate() {
        let module: LiskDelegates = self.module()
        
        // delegate
        let delegate = module.delegate()
        let model = self.blockSuccess(delegate)!
        
        // test
        XCTAssertNotNil(model)
    }
    
    /// test delegate with username
    func testDelegate_Username() {
        let module: LiskDelegates = self.module()
        
        // delegate
        let delegate = module.delegate(username: "cc001")
        let model = self.blockSuccess(delegate)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.username, "cc001")
    }
    
    /// test delegate with unknown username
    func testDelegate_UnknownUsername() {
        let module: LiskDelegates = self.module()
        
        // delegate
        let delegate = module.delegate(username: "xxxXXXxxx")
        let error = self.blockError(delegate)
        
        // test
        XCTAssertNotNil(error)
        XCTAssertEqual(error, LiskError.parse)
    }
    
    /// test forgers
    func testForgers() {
        let module: LiskDelegates = self.module()
        
        // forgers
        let forgers = module.forgers()
        let response = self.blockSuccess(forgers)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test forgers with offset and limit
    func testForgers_OffsetAndLimit() {
        let module: LiskDelegates = self.module()
        
        // forgers
        let forgers = module.forgers(limit: 5, offset: 20)
        let response = self.blockSuccess(forgers)!
        
        // test
        XCTAssertEqual(response.meta.offset, 20)
        XCTAssertEqual(response.meta.limit, 5)
        XCTAssertEqual(response.data.count, 5)
    }
    
    /// test forging statistics
    func testForgingStatistics() {
        let module: LiskDelegates = self.module()
        
        // forgingStatistics
        let forgingStatistics = module.forgingStatistics(address: "3117604376908782776L")
        let _ = self.blockSuccess(forgingStatistics)!
    }
}
