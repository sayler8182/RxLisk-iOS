//
//  NSNumber.swift
//  RxLisk
//
//  Created by Konrad on 5/14/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

extension UInt64 {
    
    /// String from UInt64
    var string: String {
        return String(self)
    }
}
    
extension Double {
    
    /// Fixed point
    var fixedPoint: UInt64 {
        return UInt64(self * LiskConstants.fixedPoint)
    }
}
