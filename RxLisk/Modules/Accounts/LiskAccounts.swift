//
//  LiskAccounts.swift
//  RxLisk
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Accounts
public struct LiskAccounts: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskAccounts {
    enum Endpoint: LiskEndpoint {
        case accounts
        
        var endpoint: String {
            switch self {
            case .accounts:
                return "/api/accounts"
            }
        }
    }
}

// MARK: - GET Accounts
public extension LiskAccounts {
    
    /// Search for matching accounts in the system.
    ///
    /// - Parameters:
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - username: Delegate username to query
    ///   - limit: Limit applied to results
    ///   - offset: Offset value for results
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         balance:asc,
    ///         balance:desc,
    func accounts(address: String? = nil,
                  publicKey: String? = nil,
                  secondPublicKey: String? = nil,
                  username: String? = nil,
                  limit: Int? = nil,
                  offset: Int? = nil,
                  sort: SortAccount? = nil) -> Single<AccountResponse<[Account]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["address"] = address
        parameters["publicKey"] = publicKey
        parameters["secondPublicKey"] = secondPublicKey
        parameters["username"] = username
        parameters["limit"] = limit
        parameters["offset"] = offset
        parameters["sort"] = sort?.string
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.accounts,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
    
    /// Search for matching accounts in the system.
    ///
    /// - Parameters:
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - username: Delegate username to query
    func account(address: String? = nil,
                 publicKey: String? = nil,
                 secondPublicKey: String? = nil,
                 username: String? = nil) -> Single<Account> {
        
        // accounts
        let accounts = self.accounts(
            address: address,
            publicKey: publicKey,
            secondPublicKey: secondPublicKey,
            username: username,
            limit: 1)
        
        // first account
        let account: Single<Account> = accounts
            .map { (response) -> Account in
                guard let delegate: Account = response.data.first else {
                    throw LiskError.parse
                }
                return delegate
        }
        return account
    }
}
