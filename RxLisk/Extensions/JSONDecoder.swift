//
//  JSONDecoder.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: JSONDecoder
extension JSONDecoder{
    
    // iso 8601
    static func iso8601() -> JSONDecoder {
        enum DateError: String, Error {
            case invalidDate
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.custom { (decoder) -> Date in
            let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
            let dateString: String = try container.decode(String.self)
            
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            
            // parse date
            if let date: Date = formatter.date(from: dateString) {
                return date
            }
            
            // error
            throw DateError.invalidDate
        }
        
        return decoder
    }
}
