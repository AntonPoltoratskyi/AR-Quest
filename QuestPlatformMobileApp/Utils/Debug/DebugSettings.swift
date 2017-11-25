//
//  DebugSettings.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/11/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public struct DebugCases: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let ui                = DebugCases(rawValue: 1 << 0)
    public static let model             = DebugCases(rawValue: 1 << 1)
    public static let network           = DebugCases(rawValue: 1 << 2)
    public static let database          = DebugCases(rawValue: 1 << 3)
    public static let resources         = DebugCases(rawValue: 1 << 4)
    public static let dataUpdates       = DebugCases(rawValue: 1 << 5)
    public static let locationUpdates   = DebugCases(rawValue: 1 << 6)
    public static let notification      = DebugCases(rawValue: 1 << 7)
    public static let memoryManagement  = DebugCases(rawValue: 1 << 8)
    
    public static let all = DebugCases(rawValue: Int.max)
}

class DebugSettings {
    static let debugCases: DebugCases = [.all]
    
    static let debugPrintDateFormat = "HH:mm:ss.SSS"
    static let debugPrintDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = debugPrintDateFormat
        return formatter
    }()
}

public func debugPrint(_ items: Any..., inCase debugCases: DebugCases) {
    guard DebugSettings.debugCases.contains(debugCases) else {
        return
    }
    let dateString = DebugSettings.debugPrintDateFormatter.string(from: Date())
    debugPrint(dateString, items)
}
