//
//  LiskConstants.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

public struct LiskConstants {
    
    /// Lisk SDK version
    public static let version = "1.6.0"
    public static let fixedPoint: Double = pow(10, 8)
    
    public struct Fee {
        public static let transfer          = UInt64(0.1 * fixedPoint)
        public static let data              = UInt64(0.1 * fixedPoint)
        public static let inTransfer        = UInt64(0.1 * fixedPoint)
        public static let outTransfer       = UInt64(0.1 * fixedPoint)
        public static let signature         = UInt64(5 * fixedPoint)
        public static let delegate          = UInt64(25 * fixedPoint)
        public static let vote              = UInt64(1 * fixedPoint)
        public static let multisignature    = UInt64(5 * fixedPoint)
        public static let dapp              = UInt64(25 * fixedPoint)
    }
    
    public struct Time {
        public static let epochMilliseconds: Double     = 1464109200000
        public static let epochSeconds: TimeInterval    = epochMilliseconds / 1000
        public static let epoch: Date                   = Date(timeIntervalSince1970: epochSeconds)
    }
    
    public struct Port {
        public static let mainnet: UInt     = 8000
        public static let testnet: UInt     = 7000
        public static let ssl: UInt         = 443
    }
}
