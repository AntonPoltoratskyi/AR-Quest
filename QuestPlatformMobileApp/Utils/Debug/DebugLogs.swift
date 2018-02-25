//
//  DebugLogs.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public func debugPrint(_ items: Any..., inCase debugCases: DebugOptions) {
    guard DebugFormatter.options.contains(debugCases) else {
        return
    }
    let dateString = DebugFormatter.dateFormatter.string(from: Date())
    debugPrint(dateString, items)
}

public func deinited(_ object: AnyObject) {
    #if DEBUG
        debugPrint("\(type(of: object)) deinited")
    #endif
}
