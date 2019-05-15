//
//  Transaction.swift
//  RxLisk
//
//  Created by Konrad on 5/13/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: TransactionResponse
public struct TransactionResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension TransactionResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Offset value for results
        public let offset: Int
        
        /// Limit applied to results
        public let limit: Int
        
        /// Number of transactions in the response
        public let count: UInt
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: Transaction
public extension LiskTransactions {
    struct Transaction: LiskModel {
        
        /// Unique identifier of the transaction. Derived from the transaction signature.
        public let id: String
        
        /// Amount of Lisk to be transferred in this transaction.
        public let amount: String

        /// Transaction fee associated with this transaction.
        public let fee: String
        
        /// Describes the Transaction type.
        public let type: TransactionType
        
        /// The height of the network, at the moment where this transaction was included in the blockchain.
        public let height: UInt?
        
        /// The Id of the block, this transaction is included in.
        public let blockId: String?
        
        /// Time when the transaction was created. Unix Timestamp.
        public let timestamp: UInt
        
        /// Lisk Address of the Senders' account.
        public let senderId: String?
        
        /// The public key of the Senders' account.
        public let senderPublicKey: String
        
        /// The second public key of the Senders' account, if it exists.
        public let senderSecondPublicKey: String?
        
        /// Lisk Address of the Recipients' account.
        public let recipientId: String
        
        /// The public key of the Recipients' account.
        public let recipientPublicKey: String?
        
        /// Derived from a SHA-256 hash of the transaction object,
        /// that is signed by the private key of the account who created the transaction.
        public let signature: String
        
        /// Contains the second signature, if the transaction is sent from an account with second passphrase activated.
        public let signSignature: String?
        
        /// If the transaction is a multisignature transaction, all signatures of the members of the corresponding multisignature group will be listed here.
        public let signatures: [String]?
        
        /// Number of times that this transaction has been confirmed by the network.
        /// By forging a new block on a chain, all former blocks and their contained transactions in the chain get confirmed by the forging delegate.
        public let confirmations: Int?
        
        public let asset: Asset
        
        /// The timestamp of the moment, where a node discovered a transaction for the first time.
        public let receivedAt: String?
        
        /// Number of times, a single transaction object has been broadcasted to another peer.
        public let relays: Int?
        
        /// Only present in transactions sent from a multisignature account, or transactions type 4 (multisignature registration).
        /// False, if the minimum amount of signatures to sign this transaction has not been reached yet.
        /// True, if the minimum amount of signatures has been reached.
        public let ready: Bool?
    }
}

// MARK: Transaction
public extension LiskTransactions.Transaction {
    
    /// Type of transactions supported on Lisk network
    enum TransactionType: UInt8, Decodable {
        case transfer                   = 0
        case registerSecondPassphrase   = 1
        case registerDelegate           = 2
        case castVotes                  = 3
        case registerMultisignature     = 4
        case createDapp                 = 5
        case transferIntoDapp           = 6
        case transferOutOfDapp          = 7
    }
}

// MARK: Asset
public extension LiskTransactions.Transaction {
    struct Asset: Decodable {
        public let delegate: Delegate
    }
}

// MARK: Delegate
public extension LiskTransactions.Transaction.Asset {
    struct Delegate: Decodable {
        public let username: String
        public let publicKey: String
        public let address: String
    }
}
