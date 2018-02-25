//
//  DebugOptions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/11/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public struct DebugOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let ui        = DebugOptions(rawValue: 1 << 0)
    public static let network   = DebugOptions(rawValue: 1 << 1)
    public static let memory    = DebugOptions(rawValue: 1 << 2)
    public static let resources = DebugOptions(rawValue: 1 << 3)
    public static let location  = DebugOptions(rawValue: 1 << 4)
    public static let database  = DebugOptions(rawValue: 1 << 5)
    
    public static let all       = DebugOptions(rawValue: Int.max)
}


