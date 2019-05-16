//
//  LiskPeersTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskPeersTests
class LiskPeersTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskPeers {
        
        return LiskPeers(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test peers
    func testPeers() {
        let module: LiskPeers = self.module()
        
        // peers
        let peers = module.peers()
        let response = self.blockSuccess(peers)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test peer
    func testPeer() {
        let module: LiskPeers = self.module()
        
        // peer
        let peer = module.peer(ip: "45.122.123.61")
        let model = self.blockSuccess(peer)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.ip, "45.122.123.61")
    }
}
