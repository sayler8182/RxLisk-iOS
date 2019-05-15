//
//  SortAccounts.swift
//  RxLisk
//
//  Created by Konrad on 5/11/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

public extension LiskAccounts {
    struct SortAccount {
        public let column: Column
        public let direction: Direction
        
        public var string: String {
            return String(format: "%@:%@", self.column.rawValue, self.direction.rawValue)
        }
        
        public enum Column: String {
            case balance            = "balance"
        }
        public enum Direction: String {
            case asc    = "asc"
            case desc   = "desc"
        }
    }
}
