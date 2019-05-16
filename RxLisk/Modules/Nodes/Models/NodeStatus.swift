//
//  NodeStatus.swift
//  RxLisk
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: NodeStatusResponse
public struct NodeStatusResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension NodeStatusResponse {
    
    // MARK: Meta
    struct Meta: Decodable { }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: NodeStatus
public extension LiskNodes {
    struct NodeStatus: LiskModel {
        
        /// Broadhash is established as an aggregated rolling hash of the past five blocks present in the database. Broadhash consensus serves a vital function for the Lisk network in order to prevent forks. It ensures that a majority of available peers agree that it is acceptable to forge.
        public let broadhash: String
        
        /// Percentage of the connected peers, that have the same broadhash as the querying node.
        public let consensus: UInt
        
        /// Current time of the node in miliseconds (Unix Timestamp).
        public let currentTime: UInt
        
        /// Current block height of the node. Represents the current number of blocks in the chain on the node.
        public let height: UInt
        
        /// True if the blockchain loaded.
        public let loaded: Bool
        
        /// Current block height of the network. Represents the current number of blocks in the chain on the network.
        public let networkHeight: UInt
        
        /// Number of seconds that have elapsed since the Lisk epoch time (Lisk Timestamp).
        public let secondsSinceEpoch: UInt
        
        /// True if the node syncing with other peers.
        public let syncing: Bool
        
        /// Transactions known to the node.
        public let transactions: Transactions
    }
}

// MARK: Fee
public extension LiskNodes.NodeStatus {
    struct Transactions: Decodable {
        
        /// Number of unconfirmed Transactions known to the node.
        public let unconfirmed: UInt
        
        /// Number of unsigned Transactions known to the node.
        public let unsigned: UInt
        
        /// Number of unprocessed Transactions known to the node.
        public let unprocessed: UInt
        
        /// Number of confirmed Transactions known to the node.
        public let confirmed: UInt
        
        /// Number of total Transactions known to the node.
        public let total: UInt
    }
}
