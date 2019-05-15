//
//  Votes.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: VotesResponse
public struct VotesResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension VotesResponse {
    
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

// MARK: Votes
public extension LiskVotes {
    struct Votes: LiskModel {
        
        /// The Lisk Address of the queried account.
        public let address: String
        
        /// The balance of the queried account.
        public let balance: String
        
        /// Username of the account, if the queried account is a delegate
        public let username: String
        
        /// Public key of the queried account.
        public let publicKey: String?
        
        /// Number of votes that are already placed by the queried account.
        public let votesUsed: Int?
        
        /// Number of votes that are available for the queried account.
        /// Derives from 101(max possible votes) - votesUsed(alreadu used votes)
        public let votesAvailable: Int?
        
        /// List of placed votes by the queried account.
        public let votes: [Vote]
    }
}

// MARK: Vote
public extension LiskVotes.Votes {
    struct Vote: Decodable {
        
        /// Lisk Address of the delegate the queried account voted for.
        public let address: String
        
        /// Public key of the delegate the queried account voted for.
        public let publicKey: String
        
        /// Balance of the delegate the queried account voted for.
        public let balance: String
        
        /// Username of the delegate the queried account voted for.
        public let username: String
    }
}
