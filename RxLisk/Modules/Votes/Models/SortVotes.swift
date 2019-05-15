//
//  SortVotes.swift
//  RxLisk
//
//  Created by Konrad on 5/10/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

public extension LiskVotes {
    struct SortVoters {
        public let column: Column
        public let direction: Direction
        
        public var string: String {
            return String(format: "%@:%@", self.column.rawValue, self.direction.rawValue)
        }
        
        public enum Column: String {
            case publicKey          = "publicKey"
            case balance            = "balance"
            case username           = "username"
        }
        public enum Direction: String {
            case asc    = "asc"
            case desc   = "desc"
        }
    }
    
    struct SortVotes {
        public let column: Column
        public let direction: Direction
        
        public var string: String {
            return String(format: "%@:%@", self.column.rawValue, self.direction.rawValue)
        }
        
        public enum Column: String {
            case username           = "username"
            case balance            = "balance"
        }
        public enum Direction: String {
            case asc    = "asc"
            case desc   = "desc"
        }
    }
}
