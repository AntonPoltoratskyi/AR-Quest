//
//  PropertyList.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public final class PropertyList {
    
    public let name: String
    public let bundle: Bundle
    
    init(name: String, bundle: Bundle = .main) {
        self.name = name
        self.bundle = bundle
    }
    
    func parse<T: Decodable>() throws -> T {
        guard let data = self.data() else {
            fatalError("File not found: \(self.name)")
        }
        return try PropertyListDecoder().decode(T.self, from: data)
    }
    
    func parse() -> [String: Any] {
        guard let data = self.data() else {
            fatalError("File not found: \(self.name)")
        }
        guard let dictionary = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [String: Any] else {
            fatalError("Couldn't parse dictionary from .plist named: \(self.name)")
        }
        return dictionary
    }
    
    private func data() -> Data? {
        guard let dataURL = self.bundle.url(forResource: self.name, withExtension: "plist") else {
            debugPrint("File not found: \(self.name)", inCase: [.resources])
            return nil
        }
        return try? Data(contentsOf: dataURL)
    }
}
