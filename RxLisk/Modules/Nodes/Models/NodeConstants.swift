//
//  NodeConstants.swift
//  RxLisk
//
//  Created by Konrad on 5/16/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: NodeConstantsResponse
public struct NodeConstantsResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension NodeConstantsResponse {
    
    // MARK: Meta
    struct Meta: Decodable { }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: NodeConstants
public extension LiskNodes {
    struct NodeConstants: LiskModel {
        
        /// Timestamp of first block on the network.
        public let epoch: String
        
        /// The Reward, each forger will get for forging a block at the current slot.
        /// After a certain amount of slots, the reward will be reduced.
        public let milestone: String
        
        /// The build number.
        /// Consists of v + the date and time of the build of the node.
        public let build: String
        
        /// The last commit that was added to the codebase.
        public let commit: String
        
        /// The Lisk Core version, that the node is running on.
        public let version: String
        
        /// The Lisk Core protocol version, that the node is running on.
        public let protocolVersion: String?
        
        /// Describes the network.
        /// The nethash describes e.g. the Mainnet or the Testnet, that the node is connecting to.
        public let nethash: String
        
        /// Total supply of LSK in the network.
        public let supply: String
        
        /// The reward a delegate will get for forging a block. Depends on the slot height.
        public let reward: String
        
        /// Unique identifier of the node. Random string.
        public let nonce: String
        
        public let fees: Fees
    }
}

// MARK: Fee
public extension LiskNodes.NodeConstants {
    struct Fees: Decodable {
        public let send: String
        public let vote: String
        public let secondSignature: String
        public let delegate: String
        public let multisignature: String
        public let dappRegistration: String
        public let dappWithdrawal: String
        public let dappDeposit: String
    }
}
