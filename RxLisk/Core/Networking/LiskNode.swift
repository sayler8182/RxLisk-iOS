//
//  LiskNode.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

/// Node configuration
public struct LiskNodeConfig {
    
    /// Use https
    public let ssl: Bool
    
    /// Selected Node selection
    public let node: LiskNode
    
    /// Port to connect to
    public let port: UInt
    
    public init(ssl: Bool,
                node: LiskNode,
                port: UInt) {
        self.ssl = ssl
        self.node = node
        self.port = port
    }
}

public extension LiskNodeConfig {
    
    /// Mainnet node
    static let mainnet: LiskNodeConfig = {
        return LiskNodeConfig(
            ssl: true,
            node: LiskNode.mainnet[0],
            port: LiskConstants.Port.mainnet)
    }()
    
    /// Testnet default node
    static let testnet: LiskNodeConfig = {
        return LiskNodeConfig(
            ssl: false,
            node: LiskNode.testnet[0],
            port: LiskConstants.Port.testnet)
    }()
}

/// Represents a Lisk node
public struct LiskNode {
    
    /// Hostname or IP address of this node
    public let hostname: String
    
    public init(hostname: String) {
        self.hostname = hostname
    }
}


public extension LiskNode {
    
    /// Mainnet nodes
    static let mainnet: [LiskNode] = [
        LiskNode(hostname: "hub21.lisk.io"),
        LiskNode(hostname: "hub22.lisk.io"),
        LiskNode(hostname: "hub23.lisk.io"),
        LiskNode(hostname: "hub24.lisk.io"),
        LiskNode(hostname: "hub25.lisk.io"),
        LiskNode(hostname: "hub26.lisk.io"),
        LiskNode(hostname: "hub27.lisk.io"),
        LiskNode(hostname: "hub28.lisk.io"),
        LiskNode(hostname: "hub31.lisk.io"),
        LiskNode(hostname: "hub32.lisk.io"),
        LiskNode(hostname: "hub33.lisk.io"),
        LiskNode(hostname: "hub34.lisk.io"),
        LiskNode(hostname: "hub35.lisk.io"),
        LiskNode(hostname: "hub36.lisk.io"),
        LiskNode(hostname: "hub37.lisk.io"),
        LiskNode(hostname: "hub38.lisk.io")
    ]
    
    /// Testnet nodes
    static let testnet: [LiskNode] = [
        LiskNode(hostname: "testnet.lisk.io")
    ]
}
