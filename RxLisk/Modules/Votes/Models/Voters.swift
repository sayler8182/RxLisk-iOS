//
//  Voters.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: VoterResponse
public struct VotersResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension VotersResponse {
    
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

// MARK: Voters
public extension LiskVotes {
    struct Voters: LiskModel {
        
        /// The delegates' username.
        /// A delegate chooses the username by registering a delegate on the Lisk network.
        /// It is unique and cannot be changed later.
        public let username: String
        
        /// The public key of the delegate.
        public let publicKey: String?
        
        /// The voters weight of the delegate.
        /// Represents the total amount of Lisk (in Beddows) that the delegates' voters own.
        /// The voters weight decides which rank the delegate gets in relation to the other delegates and their voters weights.
        public let votes: Int
        
        /// The Lisk Address of a delegate.
        public let address: String
        
        /// Account balance. Amount of Lisk the delegate account owns
        public let balance: String
        
        /// List of accounts that voted for the queried delegate.
        public let voters: [Voter]
    }
}

// MARK: Voter
public extension LiskVotes.Voters {
    struct Voter: Decodable {
        
        /// The Lisk Address of the account that voted for the queried delegate.
        public let address: String
        
        /// Public key of the account that voted for the queried delegate.
        public let publicKey: String
        
        /// Balance of the account that voted for the queried delegate.
        public let balance: String
    }
}
