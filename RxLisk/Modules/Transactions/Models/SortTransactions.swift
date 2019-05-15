//
//  SortTransactions.swift
//  RxLisk
//
//  Created by Konrad on 5/13/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

public extension LiskTransactions {
    struct SortTransaction {
        public let column: Column
        public let direction: Direction
        
        public var string: String {
            return String(format: "%@:%@", self.column.rawValue, self.direction.rawValue)
        }
        
        public enum Column: String {
            case amount             = "amount"
            case fee                = "fee"
            case type               = "type"
        }
        public enum Direction: String {
            case asc    = "asc"
            case desc   = "desc"
        }
    }
}
