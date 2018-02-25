//
//  DispatchQueue.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/31/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static func queue(for type: AnyClass, qos: DispatchQoS = .default) -> DispatchQueue {
        let bundle = Bundle(for: type)
        let label = "\(bundle.bundleIdentifier).\(String(describing: type))"
        return DispatchQueue(label: label, qos: qos)
    }
}
