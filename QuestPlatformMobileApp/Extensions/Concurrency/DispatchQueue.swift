//
//  DispatchQueue.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/31/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static func label(forType type: AnyObject.Type, inBundle bundle: Bundle) -> String {
        return "\(bundle.bundleIdentifier)-\(String(describing: type))"
    }
}
