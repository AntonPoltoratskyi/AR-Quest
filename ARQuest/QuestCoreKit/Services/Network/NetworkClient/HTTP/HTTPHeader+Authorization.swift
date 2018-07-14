//
//  HTTPHeader+Authorization.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 13.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

extension Dictionary where Key == Value, Key == String {
    static func authorization(_ token: String) -> [String: String] {
        return ["Authorization": "Bearer \(token)"]
    }
}
