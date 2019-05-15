//
//  ForgingStatistic.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: ForgingStatisticResponse
public struct ForgingStatisticResponse<T: Decodable>: LiskResponse {
    public let meta: Meta
    public let data: T
    public let links: Links
}

// MARK: Meta / Links
public extension ForgingStatisticResponse {
    
    // MARK: Meta
    struct Meta: Decodable {
        
        /// Starting unix timestamp
        public let fromTimestamp: UInt
        
        /// Ending unix timestamp
        public let toTimestamp: UInt
    }
    
    // MARK: Links
    struct Links: Decodable { }
}

// MARK: ForgingStatistic
public extension LiskDelegates {
    struct ForgingStatistic: LiskModel {
        
        /// Amount of fees, the delegate earned during the timespan.
        public let fees: String
        
        /// Amount of rewards, the delegate earned during the timespan.
        public let rewards: String
        
        /// Amount of Lisk, that have been transferred inside the forged blocks of a delegate, during the timespan.
        public let forged: String
        
        /// Amount of blocks, that the delegate has forged during the timespan.
        public let count: String
    }
} 
