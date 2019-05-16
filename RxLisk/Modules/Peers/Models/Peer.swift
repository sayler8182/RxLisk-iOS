//
//  Peer.swift
//  RxLisk
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: PeerResponse
public struct PeerResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension PeerResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Offset value for results
        public let offset: Int
        
        /// Limit applied to results
        public let limit: Int
        
        /// Number of peers in the response
        public let count: Int
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: Peer
public extension LiskPeers {
    struct Peer: LiskModel {
        
        /// IPv4 address of the peer node.
        public let ip: String?
        
        /// The port the peer node uses for HTTP requests, e.g. API calls.
        public let httpPort: UInt?
        
        /// The port the peer node uses for Websocket Connections, e.g. P2P broadcasts.
        public let wsPort: UInt
        
        /// The Operating System, that the peer node runs on.
        public let os: String?
        
        /// The version of Lisk Core that the peer node runs on.
        public let version: String?
        
        /// The protocol version of Lisk Core that the peer node runs on.
        public let protocolVersion: String?
        
        /// The state of the Peer.
        /// Available values: Connected, Disconnected, Banned
        public let state: PeerState
        
        /// Network height on the peer node. Represents the current number of blocks in the chain on the peer node.
        public let height: UInt?
        
        /// Broadhash on the peer node. Broadhash is established as an aggregated rolling hash of the past five blocks present in the database.
        public let broadhash: String?
        
        /// Unique Identifier for the peer. Random string.
        public let nonce: String?
    }
}

// MARK: PeerState
public extension LiskPeers {
    enum PeerState: UInt, Decodable {
        case connected      = 0
        case disconnected   = 1
        case banned         = 2
    }
}
