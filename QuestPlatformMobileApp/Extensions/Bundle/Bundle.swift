//
//  Bundle.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/31/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Bundle {
    var bundleIdentifier: String {
        return object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
    }
    var bundleName: String {
        return object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    }
    var displayName: String {
        let displayName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return displayName ?? self.bundleName
    }
    var buildVersion: String? {
        return object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
