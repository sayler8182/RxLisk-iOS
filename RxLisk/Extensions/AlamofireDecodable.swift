//
//  DataRequest+Decodable.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 10/06/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import Foundation
import Alamofire

/// `AlamofireDecodableError` is the error type returned by CodableAlamofire.
///
/// - invalidKeyPath:   Returned when a nested dictionary object doesn't exist by special keyPath.
/// - emptyKeyPath:     Returned when a keyPath is empty.
/// - invalidJSON:      Returned when a nested json is invalid.
enum AlamofireDecodableError: Error {
    case invalidKeyPath
    case emptyKeyPath
    case invalidJSON
}

// MARK: Response decodable
extension DataRequest {
    
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    /// - parameter keyPath:           The keyPath where object decoding should be performed. Default: `nil`.
    /// - parameter decoder:           The decoder that performs the decoding of JSON into semantic `Decodable` type. Default: `JSONDecoder()`.
    /// - parameter completionHandler: The code to be executed once the request has finished and the data has been mapped by `JSONDecoder`.
    ///
    /// - returns: The request.
    @discardableResult
    func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil,
                                         keyPath: String? = nil,
                                         decoder: JSONDecoder = JSONDecoder(),
                                         completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.DecodableSerializer(keyPath, decoder),
            completionHandler: completionHandler)
    }
    private static func DecodableSerializer<T: Decodable>(_ keyPath: String?,
                                                          _ decoder: JSONDecoder) -> DataResponseSerializer<T> {
        return DataResponseSerializer { (_, response, data, error) in
            if let error = error {
                return .failure(error)
            } else if let keyPath = keyPath {
                if keyPath.isEmpty {
                    return .failure(AlamofireDecodableError.emptyKeyPath)
                } else {
                    return DataRequest.decode(byKeyPath: keyPath, decoder: decoder, response: response, data: data)
                }
            } else {
                return DataRequest.decode(decoder: decoder, response: response, data: data)
            }
        }
    }
    
    private static func decode<T: Decodable>(decoder: JSONDecoder,
                                             response: HTTPURLResponse?,
                                             data: Data?) -> Result<T> {
        let result = Request.serializeResponseData(response: response, data: data, error: nil)
        
        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private static func decode<T: Decodable>(byKeyPath keyPath: String,
                                             decoder: JSONDecoder,
                                             response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Request.serializeResponseJSON(options: [], response: response, data: data, error: nil)
        
        switch result {
        case .success(let json):
            guard let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) else {
                return .failure(AlamofireDecodableError.invalidKeyPath)
            }
            
            do {
                guard JSONSerialization.isValidJSONObject(nestedJson) else {
                    return .failure(AlamofireDecodableError.invalidJSON)
                }
                let data = try JSONSerialization.data(withJSONObject: nestedJson)
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
