//
//  Account.swift
//  RxLisk
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: AccountResponse
public struct AccountResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension AccountResponse {
    
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

// MARK: Account
public extension LiskAccounts {
    struct Account: LiskModel {
        
        /// The Lisk Address is the human readable representation of the accounts owners' public key.
        /// It consists of 21 numbers followed by a big 'L' at the end.
        public let address: String
        
        /// The public key is derived from the private key of the owner of the account.
        /// It can be used to validate that the private key belongs to the owner, but does not provide access to the owners private key.
        public let publicKey: String
        
        /// The current balance of the account in Beddows.
        public let balance: String
        
        /// The current unconfirmed balance of the account in Beddows. Includes unconfirmed transactions.
        public let unconfirmedBalance: String
        
        /// The second public key is derived from the second private key of an account, if the owner activated a second passphrase for her/his account.
        public let secondPublicKey: String?
        
        public let delegate: Delegate?
    }
}

// MARK: Delegate
public extension LiskAccounts.Account {
    struct Delegate: Decodable {
        
        /// The delegates' username.
        /// A delegate chooses the username by registering a delegate on the Lisk network.
        /// It is unique and cannot be changed later.
        public let username: String
        
        /// The voters weight of the delegate.
        /// Represents the total amount of Lisk (in Beddows) that the delegates' voters own.
        /// The voters weight decides which rank the delegate gets in relation to the other delegates and their voters weights.
        public let vote: String
        
        /// Total sum of block rewards that the delegate has forged.
        public let rewards: String?
        
        /// Total number of blocks the delegate has forged.
        public let producedBlocks: Int?
        
        /// Total number of blocks the delegate has missed.
        public let missedBlocks: Int?
        
        /// Percentage of the voters weight, that the delegate owns in relation to the total supply of Lisk.
        public let approval: Double?
        
        /// Productivity rate.
        /// Percentage of successfully forged blocks (not missed) by the delegate.
        public let productivity: Double?
        
        /// Rank of the delegate.
        /// The rank is defined by the voters weight/ approval of a delegates, in relation to all other delegates.
        public let rank: Int?
    }
}
