//
//  LiskBlocks.swift
//  RxLisk
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Blocks
public struct LiskBlocks: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskBlocks {
    enum Endpoint: LiskEndpoint {
        case blocks
        
        var endpoint: String {
            switch self {
            case .blocks:
                return "/api/blocks"
            }
        }
    }
}

// MARK: - GET Blocks
public extension LiskBlocks {
    
    /// Search for a specified block in the system.
    ///
    /// - Parameters:
    ///   - blockId: Block id to query
    ///   - height: Current height of the network
    ///   - fromTimestamp: Starting unix timestamp
    ///   - toTimestamp: Ending unix timestamp
    ///   - limit: Limit applied to results
    ///   - offset: Offset value for results
    ///   - generatorPublicKey: Public key of the forger of the block
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         height:asc,
    ///         height:desc,
    ///         totalAmount:asc,
    ///         totalAmount:desc,
    ///         totalFee:asc,
    ///         totalFee:desc,
    ///         timestamp:asc,
    ///         timestamp:desc
    func blocks(blockId: String? = nil,
                height: UInt? = nil,
                fromTimestamp: UInt? = nil,
                toTimestamp: UInt? = nil,
                limit: Int? = nil,
                offset: Int? = nil,
                generatorPublicKey: String? = nil,
                sort: SortBlock? = nil) -> Single<BlockResponse<[Block]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["blockId"] = blockId
        parameters["height"] = height
        parameters["fromTimestamp"] = fromTimestamp
        parameters["toTimestamp"] = toTimestamp
        parameters["limit"] = limit
        parameters["offset"] = offset
        parameters["generatorPublicKey"] = generatorPublicKey
        parameters["sort"] = sort?.string
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.blocks,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
    
    /// Search for a specified block in the system.
    ///
    /// - Parameters:
    ///   - blockId: Block id to query
    ///   - generatorPublicKey: Public key of the forger of the block
    func block(blockId: String? = nil,
               generatorPublicKey: String? = nil,
               sort: SortBlock? = nil) -> Single<Block> {
        
        // blocks
        let blocks = self.blocks(
            blockId: blockId,
            limit: 1,
            generatorPublicKey: generatorPublicKey)
        
        // first block
        let block: Single<Block> = blocks
            .map { (response) -> Block in
                guard let block: Block = response.data.first else {
                    throw LiskError.parse
                }
                return block
        }
        return block
    }
}
