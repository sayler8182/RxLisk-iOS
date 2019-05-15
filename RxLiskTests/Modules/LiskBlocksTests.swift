//
//  LiskBlocksTests.swift
//  RxLiskTests
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import XCTest
import RxTest
@testable import RxLisk

// MARK: LiskBlocksTests
class LiskBlocksTests: LiskTestCase {
    private var network: MockNetwork!
    private var nodeConfig: LiskNodeConfig!
    
    // module
    func module(network: MockNetwork? = nil,
                nodeConfig: LiskNodeConfig? = nil) -> LiskBlocks {
        
        return LiskBlocks(
            network: network ?? self.network,
            nodeConfig: nodeConfig ?? self.nodeConfig)
    }
    
    override func setUp() {
        super.setUp()
        
        self.network = MockNetwork()
        self.nodeConfig = LiskNodeConfig.testnet
    }
    
    /// test blocks
    func testBlocks() {
        let module: LiskBlocks = self.module()
        
        // blocks
        let blocks = module.blocks()
        let response = self.blockSuccess(blocks)!
        
        // test
        XCTAssertEqual(response.meta.offset, 0)
        XCTAssertEqual(response.meta.limit, 10)
        XCTAssertEqual(response.data.count, 10)
    }
    
    /// test block
    func testBlock() {
        let module: LiskBlocks = self.module()
        
        // block
        let block = module.block(blockId: "5393092695674011910")
        let model = self.blockSuccess(block)!
        
        // test
        XCTAssertNotNil(model)
        XCTAssertEqual(model.id, "5393092695674011910")
    }
}
