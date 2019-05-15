//
//  NewTransaction.swift
//  RxLisk
//
//  Created by Konrad on 5/14/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: NewTransactionResponse
public struct NewTransactionResponse: LiskResponse {
    public let meta: Meta
    public let data: Data
    public let links: Links
}

// MARK: Meta / Links
public extension NewTransactionResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Acceptance status for transactions
        public let status: Bool
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: Transaction
public extension NewTransactionResponse {
    struct Data: LiskModel {
        public let message: String
    }
}

// MARK: NewTransaction
public extension LiskTransactions {
    struct NewTransaction: Decodable {
        
        /// Unique identifier of the transaction. Derived from the transaction signature.
        public var id: String?
        
        /// Amount of Lisk to be transferred in this transaction.
        public let amount: UInt64
        
        /// Transaction fee associated with this transaction.
        public let fee: UInt64
        
        /// Describes the Transaction type.
        public let type: Transaction.TransactionType
        
        /// Time when the transaction was created. Unix Timestamp.
        public let timestamp: UInt32
        
        /// Lisk Address of the Senders' account.
        public let senderId: String?
        
        /// The public key of the Senders' account.
        public var senderPublicKey: String?
        
        /// The second public key of the Senders' account, if it exists.
        public var senderSecondPublicKey: String?
        
        /// Lisk Address of the Recipients' account.
        public let recipientId: String
        
        /// Derived from a SHA-256 hash of the transaction object,
        /// that is signed by the private key of the account who created the transaction.
        public var signature: String?
        
        /// Contains the second signature, if the transaction is sent from an account with second passphrase activated.
        public var signSignature: String?
        
        /// If the transaction is a multisignature transaction, all signatures of the members of the corresponding multisignature group will be listed here.
        public let signatures: [String]?
        
        /// Displays additional transaction data. Can include e.g. vote data or delegate username.
        public let asset: Asset
        
        // dict
        var dict: [String: Any] {
            var dict: [String: Any] = [:]
            dict["id"] = self.id
            dict["type"] = self.type.rawValue
            dict["amount"] = self.amount.string
            dict["fee"] = self.fee.string
            dict["recipientId"] = self.recipientId
            dict["senderPublicKey"] = self.senderPublicKey
            dict["timestamp"] = self.timestamp
            dict["asset"] = [:]
            dict["signature"] = self.signature
            dict["signSignature"] = self.signSignature
            return dict
        }
        
        init(amount: Double,
             type: Transaction.TransactionType,
             recipientId: String,
             timestamp: UInt32? = nil,
             asset: Asset? = nil) {
            self.amount = amount.fixedPoint
            self.fee = type.transactionFee
            self.type = type
            self.timestamp = timestamp ?? Crypto.timeIntervalSinceGenesis()
            self.senderId = nil
            self.senderSecondPublicKey = nil
            self.recipientId = recipientId
            self.signatures = nil
            self.asset = asset ?? Asset()
            
            // not signed
            self.id = nil
            self.senderPublicKey = nil
            self.signature = nil
            self.signSignature = nil
        }
    }
}

// MARK: Asset
public extension LiskTransactions.NewTransaction {
    struct Asset: Decodable { }
}

// MARK: Signing
public extension LiskTransactions.NewTransaction {
    
    /// Signs the current transaction
    mutating func sign(keyPair: KeyPair,
                       secondKeyPair: KeyPair? = nil) throws {
        
        // public key
        self.senderPublicKey = keyPair.publicKeyString
        
        // signature
        self.signature = LiskTransactions.NewTransaction.generateSignature(bytes: self.bytes, keyPair: keyPair)
        
        // sign signature
        if let secondKeyPair = secondKeyPair {
            self.signSignature = LiskTransactions.NewTransaction.generateSignature(bytes: self.bytes, keyPair: secondKeyPair)
        }
        
        // id
        self.id = LiskTransactions.NewTransaction.generateId(bytes: self.bytes)
    }
    
    /// Signs the current transaction
    mutating func sign(secret: String,
                       secondSecret: String? = nil) throws {
        let keyPair = try Crypto.keyPair(fromSecret: secret)
        let secondKeyPair: KeyPair?
        if let secondSecret = secondSecret {
            secondKeyPair = try Crypto.keyPair(fromSecret: secondSecret)
        } else {
            secondKeyPair = nil
        }
        
        // sign
        try sign(keyPair: keyPair, secondKeyPair: secondKeyPair)
    }
    
    /// Returns a new signed transaction based on this transaction
    static func signed(transaction: LiskTransactions.NewTransaction,
                       keyPair: KeyPair,
                       secondKeyPair: KeyPair? = nil) throws -> LiskTransactions.NewTransaction {
        var newTransaction = transaction
        try? newTransaction.sign(keyPair: keyPair, secondKeyPair: secondKeyPair)
        return newTransaction
    }
    
    /// Returns a new signed transaction based on this transaction
    static func signed(transaction: LiskTransactions.NewTransaction,
                       secret: String,
                       secondSecret: String? = nil) throws -> LiskTransactions.NewTransaction {
        var newTransaction = transaction
        try? newTransaction.sign(secret: secret, secondSecret: secondSecret)
        return newTransaction
    }
    
    // Generates transaction id
    private static func generateId(bytes: [UInt8]) -> String {
        let hash = SHA256(bytes).digest()
        let id = Crypto.byteIdentifier(from: hash)
        return "\(id)"
    }
    
    // Generates transaction signature
    private static func generateSignature(bytes: [UInt8],
                                          keyPair: KeyPair) -> String {
        let hash = SHA256(bytes).digest()
        return keyPair.sign(hash).hexString()
    }
    
    private var bytes: [UInt8] {
        return
            self.typeBytes +
                self.timestampBytes +
                self.senderPublicKeyBytes +
                self.recipientIdBytes +
                self.amountBytes +
                self.assetBytes +
                self.signatureBytes +
                self.signSignatureBytes
    }
    
    private var typeBytes: [UInt8] {
        return [self.type.rawValue]
    }
    
    private var timestampBytes: [UInt8] {
        return BytePacker.pack(self.timestamp, byteOrder: .littleEndian)
    }
    
    private var senderPublicKeyBytes: [UInt8] {
        return self.senderPublicKey?.hexBytes() ?? []
    }
    
    private var recipientIdBytes: [UInt8] {
        let value = self.recipientId.replacingOccurrences(of: "L", with: "")
        guard let number = UInt64(value) else { return [UInt8](repeating: 0, count: 8) }
        return BytePacker.pack(number, byteOrder: .bigEndian)
    }
    
    private var amountBytes: [UInt8] {
        return BytePacker.pack(self.amount, byteOrder: .littleEndian)
    }
    
    private var signatureBytes: [UInt8] {
        return self.signature?.hexBytes() ?? []
    }
    
    private var signSignatureBytes: [UInt8] {
        return self.signSignature?.hexBytes() ?? []
    }
    
    private var assetBytes: [UInt8] {
        return []
    }
}


// MARK:
public extension LiskTransactions.Transaction.TransactionType {
    
    // transaction fee
    var transactionFee: UInt64 {
        switch self {
        case .transfer:                 return LiskConstants.Fee.transfer
        case .registerSecondPassphrase: return LiskConstants.Fee.signature
        case .registerDelegate:         return LiskConstants.Fee.delegate
        case .castVotes:                return LiskConstants.Fee.vote
        case .registerMultisignature:   return LiskConstants.Fee.multisignature
        case .createDapp:               return LiskConstants.Fee.dapp
        case .transferIntoDapp:         return LiskConstants.Fee.inTransfer
        case .transferOutOfDapp:        return LiskConstants.Fee.outTransfer
        }
    }
}
