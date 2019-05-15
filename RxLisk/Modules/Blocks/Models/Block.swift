//
//  Block.swift
//  RxLisk
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: BlockResponse
public struct BlockResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension BlockResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Offset value for results
        public let offset: Int
        
        /// Limit applied to results
        public let limit: Int
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: Block
public extension LiskBlocks {
    struct Block: LiskModel {
        
        /// Unique identifier of the block. Derived from the block signature.
        public let id: String
        
        /// Versioning for future upgrades of the lisk protocol
        public let version: Int?
        
        /// Height of the network, when the block got forged.
        /// The height of the networks represents the number of blocks,
        /// that have been forged on the network since Genesis Block.
        public let height: Int
        
        /// Unix Timestamp
        public let timestamp: UInt
        
        /// Lisk Address of the delegate who forged the block.
        public let generatorAddress: String?
        
        /// Public key of th edelagte who forged the block.
        public let generatorPublicKey: String
        
        /// Bytesize of the payload hash.
        public let payloadLength: Int?
        
        /// Hash of the payload of the block. The payload of a block is comprised of the transactions the block contains. For each type of transaction exists a different maximum size for the payload.
        public let payloadHash: String?
        
        /// Derived from a SHA-256 hash of the block header,
        /// that is signed by the private key of the delegate who forged the block.
        public let blockSignature: String?
        
        ///Number of times that this Block has been confirmed by the network.
        /// By forging a new block on a chain, all former blocks in the chain get confirmed by the forging delegate.
        public let confirmations: Int?
        
        /// The id of the previous block of the chain.
        public let previousBlockId: String?
        
        /// The number of transactions processed in the block.
        public let numberOfTransactions: Int
        
        /// The total amount of Lisk transferred.
        public let totalAmount: String
        
        /// The total amount of fees associated with the block.
        public let totalFee: String
        
        /// The Lisk reward for the delegate.
        public let reward: String
        
        /// Total amount of LSK that have been forged in this Block. Consists of fees and the reward.
        public let totalForged: String
    }
}
