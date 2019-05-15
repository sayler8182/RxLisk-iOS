//
//  MockNetwork.swift
//  RxLiskTests
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Alamofire
import RxSwift
@testable import RxLisk

// MARK: MockNetwork
class MockNetwork: LiskNetwork {
    static var shared: LiskNetwork = MockNetwork()
    private let sessionManager: SessionManager
    private let debugMode: Bool
    
    required init(sessionManager: SessionManager = SessionManager.default,
                  debugMode: Bool = true) {
        self.sessionManager = sessionManager
        self.debugMode = debugMode
    }
    
    /// handle request
    func request<T: Decodable>(
        nodeConfig: LiskNodeConfig,
        endpoint: LiskEndpoint,
        method: HTTPMethod,
        headers: HTTPHeaders = [:],
        parameters: Parameters = [:]) -> Single<T> {
        return Network.shared.request(
            nodeConfig: nodeConfig,
            endpoint: endpoint,
            method: method,
            headers: headers,
            parameters: parameters)
    }
}
