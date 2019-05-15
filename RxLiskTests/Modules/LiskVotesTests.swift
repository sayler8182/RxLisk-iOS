//
//  LiskVotesTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskVotesTests
class LiskVotesTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskVotes {
        
        return LiskVotes(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test voters
    func testVoters() {
        let module: LiskVotes = self.module()
        
        // voters
        let voters = module.voters(username: "cc001")
        let response = self.blockSuccess(voters)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.voters.count, 10)
    }
    
    /// test votes
    func testVotes() {
        let module: LiskVotes = self.module()
        
        // votes
        let votes = module.votes(username: "cc001")
        let response = self.blockSuccess(votes)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.votes.count, 10)
    }
}

