//
//  LiskAccountsTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskAccountsTests
class LiskAccountsTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskAccounts {
        
        return LiskAccounts(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test accounts
    func testAccounts() {
        let module: LiskAccounts = self.module()
        
        // accounts
        let accounts = module.accounts()
        let response = self.blockSuccess(accounts)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test account
    func testAccount() {
        let module: LiskAccounts = self.module()
        
        // account
        let account = module.account(address: "7371991915110534872L")
        let model = self.blockSuccess(account)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.address, "7371991915110534872L")
    }
    
    /// test account with secret
    func testAccountWithSecret() {
        let module: LiskAccounts = self.module()
        
        // address
        let publicKey = try! Crypto.publicKey(fromSecret: self.secret)
        let address = Crypto.address(fromPublicKey: publicKey)
        
        // account
        let account = module.account(address: address)
        let model = self.blockSuccess(account)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.address, address)
        XCTAssertNotEqual(model.balance, "0")
    }
}
