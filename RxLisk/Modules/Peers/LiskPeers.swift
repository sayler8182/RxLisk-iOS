//
//  LiskPeers.swift
//  RxLisk
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Peers
public struct LiskPeers: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskPeers {
    enum Endpoint: LiskEndpoint {
        case peers
        
        var endpoint: String {
            switch self {
            case .peers:
                return "/api/peers"
            }
        }
    }
}

// MARK: - GET Peers
public extension LiskPeers {
    
    /// Search for specified peers.
    ///
    /// - Parameters:
    ///   - ip: IP of the node or delegate
    ///   - httpPort: Http port of the node or delegate
    ///   - wsPort: Web socket port for the node or delegate
    ///   - os: OS of the node
    ///   - version: Lisk version of the node
    ///   - protocolVersion: Protocol version of the node
    ///   - state: Current state of the network
    ///   - height: Current height of the network
    ///   - broadhash: Broadhash of the network
    ///   - limit: Limit applied to results
    ///   - offset: Offset value for results
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         height:asc,
    ///         height:desc,
    ///         version:asc,
    ///         version:desc,
    func peers(ip: String? = nil,
               httpPort: UInt? = nil,
               wsPort: UInt? = nil,
               os: String? = nil,
               version: String? = nil,
               protocolVersion: String? = nil,
               state: PeerState? = nil,
               height: UInt? = nil,
               broadhash: String? = nil,
               limit: Int? = nil,
               offset: Int? = nil,
               sort: SortPeer? = nil) -> Single<PeerResponse<[Peer]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["ip"] = ip
        parameters["httpPort"] = httpPort
        parameters["wsPort"] = wsPort
        parameters["os"] = os
        parameters["version"] = version
        parameters["protocolVersion"] = protocolVersion
        parameters["state"] = state?.rawValue
        parameters["height"] = height
        parameters["broadhash"] = broadhash
        parameters["limit"] = limit
        parameters["offset"] = offset
        parameters["sort"] = sort?.string
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.peers,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
    
    /// Search for specified peers.
    ///
    /// - Parameters:
    ///   - ip: IP of the node or delegate
    func peer(ip: String? = nil) -> Single<Peer> {
        
        // peers
        let peers = self.peers(ip: ip)
        
        // first peer
        let peer: Single<Peer> = peers
            .map { (response) -> Peer in
                guard let peer: Peer = response.data.first else {
                    throw LiskError.parse
                }
                return peer
        }
        return peer
    }
}
