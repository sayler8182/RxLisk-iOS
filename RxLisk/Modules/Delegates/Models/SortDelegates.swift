//
//  SortDelegates.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

public extension LiskDelegates {
    struct SortDelegate {
        public let column: Column
        public let direction: Direction
        
        public var string: String {
            return String(format: "%@:%@", self.column.rawValue, self.direction.rawValue)
        }
        
        public enum Column: String {
            case username           = "username"
            case rank               = "rank"
            case productivity       = "productivity"
            case missedBlocks       = "missedBlocks"
            case producedBlocks     = "producedBlocks"
        }
        public enum Direction: String {
            case asc    = "asc"
            case desc   = "desc"
        }
    }
}
