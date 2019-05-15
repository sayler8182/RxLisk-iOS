//
//  LiskModule.swift
//  RxLisk
//
//  Created by Konrad on 5/9/19.
//  Copyright © 2019 Limbo. All rights reserved.
//

import Foundation

/// API Service
public protocol LiskModule {
    init(network: LiskNetwork,
         nodeConfig: LiskNodeConfig)
}
