//
//  CryptoTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/14/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
@testable import RxLisk

// MARK: MnemonicPassphraseTests
class MnemonicPassphraseTests: LiskTestCase {
    
    // test passphrase
    func testPassphrase() {
        
        // address
        let publicKey = try! Crypto.publicKey(fromSecret: self.secret)
        let address = Crypto.address(fromPublicKey: publicKey)
        XCTAssertEqual(address, "8985905004777775964L")
    }
        
    // test passphrases
    func testPassphrases() {
        var passphrases: Set<String> = Set<String>()
        for _ in 0...100_000 {
            let passphrase: String = MnemonicPassphrase().passphrase
            XCTAssertFalse(passphrases.contains(passphrase))
            passphrases.insert(passphrase)
        }
    }
}
