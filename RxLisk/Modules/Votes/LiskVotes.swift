//
//  LiskVotes.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import RxSwift
import RxOptional
import Alamofire

/// Lisk Votes
public struct LiskVotes: LiskModule {
    private let network: LiskNetwork
    private let nodeConfig: LiskNodeConfig
    
    public init(network: LiskNetwork = Network.shared,
                nodeConfig: LiskNodeConfig = LiskNodeConfig.mainnet) {
        self.network = network
        self.nodeConfig = nodeConfig
    }
}

// MARK: Endpoint
extension LiskVotes {
    enum Endpoint: LiskEndpoint {
        case votes
        case voters
        
        var endpoint: String {
            switch self {
            case .votes:
                return "/api/votes"
            case .voters:
                return "/api/voters"
            }
        }
    }
}

// MARK: - GET Voters
public extension LiskVotes {
    
    /// Attention: At least one of the filter parameters must be provided.
    /// Returns all votes received by a delegate.
    ///
    /// - Parameters:
    ///   - username: Delegate username to query
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - offset: Offset value for results
    ///   - limit: Limit applied to results
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         publicKey:asc,
    //          publicKey:desc,
    ///         balance:asc,
    ///         balance:desc,
    ///         username:asc,
    ///         username:desc
    func voters(username: String? = nil,
                address: String? = nil,
                publicKey: String? = nil,
                secondPublicKey: String? = nil,
                offset: Int? = nil,
                limit: Int? = nil,
                sort: SortVoters? = nil) -> Single<VotersResponse<Voters>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["username"] = username
        parameters["address"] = address
        parameters["publicKey"] = publicKey
        parameters["secondPublicKey"] = secondPublicKey
        parameters["offset"] = offset
        parameters["limit"] = limit
        parameters["sort"] = sort
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.voters,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
}

// MARK: - GET Votes
public extension LiskVotes {
    
    /// Attention: At least one of the filter parameters must be provided.
    /// Returns all votes placed by an account.
    ///
    /// - Parameters:
    ///   - username: Delegate username to query
    ///   - address: Address of an account
    ///   - publicKey: Public key to query
    ///   - secondPublicKey: Second public key to query
    ///   - offset: Offset value for results
    ///   - limit: Limit applied to results
    ///   - sort: Fields to sort results by
    ///     Available values :
    ///         username:asc,
    ///         username:desc,
    ///         balance:asc,
    ///         balance:desc
    func votes(username: String? = nil,
               address: String? = nil,
               publicKey: String? = nil,
               secondPublicKey: String? = nil,
               offset: Int? = nil,
               limit: Int? = nil,
               sort: SortVotes? = nil) -> Single<VotesResponse<Votes>> {
        
        // parameters
        var parameters: Parameters = [:]
        parameters["username"] = username
        parameters["address"] = address
        parameters["publicKey"] = publicKey
        parameters["secondPublicKey"] = secondPublicKey
        parameters["offset"] = offset
        parameters["limit"] = limit
        parameters["sort"] = sort
        
        // request
        return self.network.request(
            nodeConfig: self.nodeConfig,
            endpoint: Endpoint.votes,
            method: HTTPMethod.get,
            headers: [:],
            parameters: parameters)
    }
}

