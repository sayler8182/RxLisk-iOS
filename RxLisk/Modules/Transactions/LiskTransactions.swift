//
//  LiskTransactions.swift
//  RxLisk
//
//  Created by Konrad on 5/13/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Transactions
public struct LiskTransactions: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskTransactions {
    enum Endpoint: LiskEndpoint {
        case transactions
        
        var endpoint: String {
            switch self {
            case .transactions:
                return "/api/transactions"
            }
        }
    }
}

// MARK: - GET Transactions
public extension LiskTransactions {
    
    /// Search for a specified transaction in the system.
    ///
    /// - Parameters:
    ///   - id: Transaction id to query
    ///   - recipientId: Recipient lisk address
    ///   - recipientPublicKey: Recipient public key
    ///   - senderId: Sender lisk address
    ///   - senderPublicKey: Sender public key
    ///   - senderIdOrRecipientId: Lisk address
    ///   - type: Transaction type (0-7)
    ///   - height: Current height of the network
    ///   - minAmount: Minimum transaction amount in Beddows
    ///   - maxAmount: Maximum transaction amount in Beddows
    ///   - fromTimestamp: Starting unix timestamp
    ///   - toTimestamp: Ending unix timestamp
    ///   - blockId: Block id to query
    ///   - limit: Limit applied to results
    ///   - offset: Offset value for results
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         amount:asc,
    ///         amount:desc,
    ///         fee:asc,
    ///         fee:desc,
    ///         type:asc,
    ///         type:desc
    ///   - data: Fuzzy additional data field to query
    func transactions(id: String? = nil,
                      recipientId: String? = nil,
                      recipientPublicKey: String? = nil,
                      senderId: String? = nil,
                      senderPublicKey: String? = nil,
                      senderIdOrRecipientId: String? = nil,
                      type: Transaction.TransactionType? = nil,
                      height: UInt? = nil,
                      minAmount: UInt? = nil,
                      maxAmount: UInt? = nil,
                      fromTimestamp: UInt? = nil,
                      toTimestamp: UInt? = nil,
                      blockId: String? = nil,
                      limit: Int? = nil,
                      offset: Int? = nil,
                      sort: SortTransaction? = nil,
                      data: String? = nil) -> Single<TransactionResponse<[Transaction]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["id"] = id
        parameters["recipientId"] = recipientId
        parameters["recipientPublicKey"] = recipientPublicKey
        parameters["senderId"] = senderId
        parameters["senderPublicKey"] = senderPublicKey
        parameters["senderIdOrRecipientId"] = senderIdOrRecipientId
        parameters["type"] = type?.rawValue
        parameters["height"] = height
        parameters["minAmount"] = minAmount
        parameters["maxAmount"] = maxAmount
        parameters["fromTimestamp"] = fromTimestamp
        parameters["toTimestamp"] = toTimestamp
        parameters["blockId"] = blockId
        parameters["limit"] = limit
        parameters["offset"] = offset
        parameters["sort"] = sort?.string
        parameters["data"] = data
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.transactions,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
    
    /// Search for a specified transaction in the system.
    ///
    /// - Parameters:
    ///   - id: Transaction id to query
    func transaction(id: String? = nil) -> Single<Transaction> {
        
        // transactions
        let transactions = self.transactions(
            id: id,
            limit: 1)
        
        // first transaction
        let transaction: Single<Transaction> = transactions
            .map { (response) -> Transaction in
                guard let transaction: Transaction = response.data.first else {
                    throw LiskError.parse
                }
                return transaction
        }
        return transaction
    }
}

// MARK: - POST Transactions
public extension LiskTransactions {
    
    /// Submits signed transaction object for processing by the transaction pool.
    /// Transaction objects can be generated locally either by using Lisk Commander or with Lisk Elements.
    ///
    /// - Parameters:
    ///   - transaction: Transaction object to submit to the network
    func sendTransaction(transaction: NewTransaction) -> Single<NewTransactionResponse> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters = transaction.dict
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.transactions,
            method: HTTPMethod.post,
            headers: [:],
            parameters: parameters)
    }
}
