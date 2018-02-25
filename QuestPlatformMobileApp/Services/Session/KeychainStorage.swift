//
//  KeychainStorage.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/24/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import KeychainSwift

public final class KeychainStorage {
    
    private let keychain: KeychainSwift
    
    public init() {
        self.keychain = KeychainSwift()
        self.keychain.synchronizable = false
    }
    
    public func set(_ string: String, forKey key: String) {
        keychain.set(string, forKey: key)
    }
    
    public func deleteValue(forKey key: String) {
        keychain.delete(key)
    }
    
    public func getString(forKey key: String) -> String? {
        return keychain.get(key)
    }
}
