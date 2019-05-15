//
//  LiskNetwork.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Alamofire
import RxSwift

// MARK: LiskEndpoint
public protocol LiskEndpoint {
    var endpoint: String { get }
}

// MARK: LiskNetwork
public protocol LiskNetwork {
    static var shared: LiskNetwork { get }
    
    init(sessionManager: SessionManager,
         debugMode: Bool)
    
    func request<T: Decodable>(nodeConfig: LiskNodeConfig,
                               endpoint: LiskEndpoint,
                               method: HTTPMethod,
                               headers: HTTPHeaders,
                               parameters: Parameters) -> Single<T>
} 

// MARK: Network
public struct Network: LiskNetwork {
    
    // shared
    public static let shared: LiskNetwork = Network()
    
    // session manager
    private let sessionManager: SessionManager
    
    // debug mode
    private var debugMode: Bool
    
    public init(sessionManager: SessionManager = SessionManager.default,
                debugMode: Bool = true) {
        self.sessionManager = sessionManager
        self.debugMode = debugMode
    }
}

// MARK: LiskError
enum LiskError: String, Error, Equatable {
    case incorrectResponse
    case parse
    case unknown
}

// MARK: Requests
public extension Network {
    
    /// handle request
    func request<T: Decodable>(
        nodeConfig: LiskNodeConfig,
        endpoint: LiskEndpoint,
        method: HTTPMethod,
        headers: HTTPHeaders = [:],
        parameters: Parameters = [:]) -> Single<T> {
        return Single.create { (subscribe) -> Disposable in
            
            // encoding
            let encoding: ParameterEncoding
            switch method {
            case .get:      encoding = URLEncoding(destination: .methodDependent)
            case .post:     encoding = JSONEncoding()
            case .put:      encoding = JSONEncoding()
            case .delete:   encoding = URLEncoding(destination: .methodDependent)
            default:        encoding = JSONEncoding()
            }
            
            // append additionals headers
            var headers: HTTPHeaders = headers
            headers["Content-Type"] = "application/json"
            
            // path
            let path: String = String(
                format: "%@://%@:%u%@",
                nodeConfig.ssl ? "https" : "http",
                nodeConfig.node.hostname,
                nodeConfig.port,
                endpoint.endpoint
            )
            
            // debug
            if self.debugMode {
                print("")
                print("        ----")
                print("        URL:       ", path)
                print("        METHOD:    ", method.rawValue.uppercased())
                if headers.isEmpty == false {
                    print("        HEADERS:")
                    for header in headers {
                        print("         ", header.key, ": ", header.value)
                    }
                }
                if parameters.isEmpty == false {
                    print("        PARAMETERS:")
                    for parameter in parameters {
                        print("         ", parameter.key, ": ", parameter.value)
                    }
                }
                print("        ----")
                print("")
            }
            
            // make a request
            let manager: SessionManager = self.sessionManager
            let queue: DispatchQueue = DispatchQueue(label: "rxlisk.request", qos: .background)
            let dataRequest: DataRequest? = manager.request(
                path,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
                .validate()
                .responseDecodable(
                    queue: queue,
                    decoder: JSONDecoder.iso8601(),
                    completionHandler: { (response: DataResponse<T>) in
                        
                        // parse error
                        if let _: DecodingError = response.result.error as? DecodingError {
                            print(String(data: response.data!, encoding: .utf8)!)
                            subscribe(.error(LiskError.parse))
                            return
                        }
                        
                        // response error
                        if let value: T = response.result.value {
                            subscribe(.success(value))
                        } else {
                            print(String(data: response.data!, encoding: .utf8)!)
                            subscribe(.error(LiskError.incorrectResponse))
                        }
                })
            return Disposables.create { dataRequest?.cancel() }
            }
            .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
    }
}
