//
//  Bundle.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/31/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Bundle {
    
    public var bundleIdentifier: String {
        return object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
    }
    
    /// Project bundle name
    public var bundleName: String {
        return object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
    }
    
    /// App name which displaying in Springboard
    public var displayName: String {
        let displayName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return displayName ?? self.bundleName
    }
    
    public var buildVersion: String? {
        return object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    public var serverURL: URL {
        let urlString = object(forInfoDictionaryKey: "SERVER_URL") as! String
        return URL(string: urlString)!
    }
}
