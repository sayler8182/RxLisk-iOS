//
//  LiskTransactionsTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/13/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskTransactionsTests
class LiskTransactionsTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskTransactions {
        
        return LiskTransactions(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test transactions
    func testTransactions() {
        let module: LiskTransactions = self.module()
        
        // transactions
        let transactions = module.transactions()
        let response = self.blockSuccess(transactions)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test transaction
    func testTransaction() {
        let module: LiskTransactions = self.module()
        
        // transactions
        let transactions = module.transaction(id: "8904615286204140458")
        let model = self.blockSuccess(transactions)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, "8904615286204140458")
    }
    
    func testNewTransaction() {
        let module: LiskTransactions = self.module()
        
        // transaction
        var transaction = LiskTransactions.NewTransaction(
            amount: 0.1,
            type: .transfer,
            recipientId: "7371991915110534872L")
        
        try! transaction.sign(secret: self.secret)
        let request = module.sendTransaction(transaction: transaction)
        let response = self.blockSuccess(request)!
        
        // test
        XCTAssertEqual(response.meta.status, true)
        XCTAssertEqual(response.data.message, "Transaction(s) accepted")
        
    }
}
