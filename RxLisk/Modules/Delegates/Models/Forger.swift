//
//  Forger.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: ForgerResponse
public struct ForgerResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension ForgerResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Offset value for results
        public let offset: Int
        
        /// Limit applied to results
        public let limit: Int
        
        /// Currently active slot
        public let currentSlot: UInt
        
        /// Slot of the last processed block
        public let lastBlockSlot: UInt
        
        /// ID of the last processed block
        public let lastBlock: UInt
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: Forger
public extension LiskDelegates {
    struct Forger: LiskModel {
        
        /// The delegates' username.
        /// A delegate chooses the username by registering a delegate on the Lisk network.
        /// It is unique and cannot be changed later.
        public let username: String
        
        /// The public key is derived from the private key of the owner of the account.
        /// It can be used to validate that the private key belongs to the owner, but not provide access to the owners private key.
        public let publicKey: String
        
        /// The Lisk Address is the human readable representation of the accounts owners' public key.
        /// It consists of 21 numbers followed by a big 'L' at the end.
        public let address: String
        
        /// Returns the slot number in which the forger will be able to forge the next block. Each slot has a timespan of 10 seconds.
        /// The first slot began directly after the Lisk Epoch Time.
        public let nextSlot: UInt
    }
}
