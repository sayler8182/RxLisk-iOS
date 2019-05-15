//
//  LiskDelegates.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Delegates
public struct LiskDelegates: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskDelegates {
    enum Endpoint: LiskEndpoint {
        case delegates
        case forgers
        case forgingStatistics(address: String)
        
        var endpoint: String {
            switch self {
            case .delegates:
                return "/api/delegates"
            case .forgers:
                return "/api/delegates/forgers"
            case .forgingStatistics(let address):
                return"/api/delegates/\(address)/forging_statistics"
            }
        }
    }
}

// MARK: - GET Delegates
public extension LiskDelegates {
    
    /// Search for a specified delegate in the system.
    ///
    /// - Parameters:
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - username: Delegate username to query
    ///   - offset: Offset value for results
    ///   - limit: Limit applied to results
    ///   - search: Fuzzy delegate username to query
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         username:asc,
    ///         username:desc,
    ///         rank:asc,
    ///         rank:desc,
    ///         productivity:asc,
    ///         productivity:desc,
    ///         missedBlocks:asc,
    ///         missedBlocks:desc,
    ///         producedBlocks:asc,
    ///         producedBlocks:desc
    func delegates(address: String? = nil,
                   publicKey: String? = nil,
                   secondPublicKey: String? = nil,
                   username: String? = nil,
                   offset: Int? = nil,
                   limit: Int? = nil,
                   search: String? = nil,
                   sort: SortDelegate? = nil) -> Single<DelegateResponse<[Delegate]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["address"] = address
        parameters["publicKey"] = publicKey
        parameters["secondPublicKey"] = secondPublicKey
        parameters["username"] = username
        parameters["offset"] = offset
        parameters["limit"] = limit
        parameters["search"] = search
        parameters["sort"] = sort?.string
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.delegates,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
    
    /// Search for a specified delegate in the system.
    ///
    /// - Parameters:
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - username: Delegate username to query
    ///   - search: Fuzzy delegate username to query
    func delegate(address: String? = nil,
                  publicKey: String? = nil,
                  secondPublicKey: String? = nil,
                  username: String? = nil,
                  search: String? = nil) -> Single<Delegate> {
        
        // delegates
        let delegates = self.delegates(
            address: address,
            publicKey: publicKey,
            secondPublicKey: secondPublicKey,
            username: username,
            limit: 1,
            search: search)
        
        // first delegate
        let delegate: Single<Delegate> = delegates
            .map { (response) -> Delegate in
                guard let delegate: Delegate = response.data.first else {
                    throw LiskError.parse
                }
                return delegate
        }
        return delegate
    }
}

// MARK: - GET Forgers
public extension LiskDelegates {
    
    /// Returns a list of the next forgers in this delegate round.
    ///
    /// - Parameters:
    ///   - limit: Limit applied to results
    ///   - offset: Offset value for results
    func forgers(limit: Int? = nil,
                 offset: Int? = nil) -> Single<ForgerResponse<[Forger]>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["limit"] = limit
        parameters["offset"] = offset
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.forgers,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
}

// MARK: - GET ForgingStatistics
public extension LiskDelegates {
    
    /// By passing an existing delegate address and the desired unix timestamps, you can get its forging statistics within the specified timespan.
    /// If no timestamps are provided, it will use the timestamps from Lisk epoch to current date.
    ///
    /// - Parameters:
    ///   - address: Lisk address of a delegate
    ///   - fromTimestamp: Starting unix timestamp
    ///   - toTimestamp: Ending unix timestamp
    func forgingStatistics(address: String,
                           fromTimestamp: UInt? = nil,
                           toTimestamp: UInt? = nil) -> Single<ForgingStatisticResponse<ForgingStatistic>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["fromTimestamp"] = fromTimestamp
        parameters["toTimestamp"] = toTimestamp
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.forgingStatistics(address: address),
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
}

