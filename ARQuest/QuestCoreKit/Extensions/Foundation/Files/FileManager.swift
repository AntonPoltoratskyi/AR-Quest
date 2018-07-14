//
//  FileManager.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/30/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension FileManager {
    static var libraryDirectory: URL {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
    }
    static var applicationSupportDirectory: URL {
        return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    static var cacheDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func removeItemIfExists(at url: URL) {
        if fileExists(atPath: url.path) {
            try? removeItem(at: url)
        }
    }
}
