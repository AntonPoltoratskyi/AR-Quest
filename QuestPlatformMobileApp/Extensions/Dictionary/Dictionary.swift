//
//  Dictionary.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/27/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public extension Dictionary {
    func merging(_ other: Dictionary<Key, Value>) -> [Dictionary.Key : Dictionary.Value] {
        return merging(other, uniquingKeysWith: { current, new in new })
    }
}
