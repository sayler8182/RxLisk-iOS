//
//  LiskNodesTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskNodesTests
class LiskNodesTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskNodes {
        
        return LiskNodes(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test node constants
    func testNodeConstants() {
        let module: LiskNodes = self.module()
        
        // constants
        let constants = module.constants()
        let response = self.blockSuccess(constants)!
        
        // test
        XCTAssertEqual(response.data.protocolVersion, "1.0")
    }
    
    /// test node status
    func testNodeStatus() {
        let module: LiskNodes = self.module()
        
        // status
        let status = module.status()
        _ = self.blockSuccess(status)!
    }
}
