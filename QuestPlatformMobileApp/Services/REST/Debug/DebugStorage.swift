//
//  DebugStorage.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class DebugStorage: Codable {
    
    var quests: [Quest]
    
    init(quests: [Quest]) {
        self.quests = quests
    }
    
    private static let key = "debug-storage"
    
    static func restore() -> DebugStorage {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: key) else {
            return DebugStorage(quests: [])
        }
        let decoder = JSONDecoder()
        return try! decoder.decode(DebugStorage.self, from: data)
    }
    
    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return
        }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: type(of: self).key)
    }
}
