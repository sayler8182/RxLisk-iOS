//
//  LiskNodes.swift
//  RxLisk
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Nodes
public struct LiskNodes: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskNodes {
    enum Endpoint: LiskEndpoint {
        case nodeConstants
        case nodeStatus
        
        var endpoint: String {
            switch self {
            case .nodeConstants:
                return "/api/node/constants"
            case .nodeStatus:
                return "/api/node/status"
            }
        }
    }
}

// MARK: - GET Nodes
public extension LiskNodes {
    
    /// Returns all current constants data on the system, e.g. Lisk epoch time and version.
    func constants() -> Single<NodeConstantsResponse<NodeConstants>> {
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.nodeConstants,
            method: HTTPMethod.get,
            headers: [:],
            parameters: [:])
    }
    
    /// Returns all current status data of the node, e.g. height and broadhash.
    func status() -> Single<NodeStatusResponse<NodeStatus>> {
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.nodeStatus,
            method: HTTPMethod.get,
            headers: [:],
            parameters: [:])
    }
}
