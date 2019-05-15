//
//  Optional.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

// MARK: Optional
extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        switch(self) {
        case .none:             return defaultValue
        case .some(let value):  return value
        }
    }
    
    var isNil: Bool {
        switch(self) {
        case .none:             return true
        case .some:             return false
        }
    }
    
    var isNotNil: Bool {
        switch(self) {
        case .none:             return false
        case .some:             return true
        }
    }
}
