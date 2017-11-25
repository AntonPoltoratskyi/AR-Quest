//
//  PropertyListParser.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public class PropertyListParser {
    
    public static func parsePropertyList(named fileName: String) -> [String: Any] {
        guard let data = resourceData(named: fileName, withExtension: "plist") else {
            fatalError("File not found: \(fileName)")
        }
        guard let dictionary = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [String: Any] else {
            fatalError("Couldn't parse dictionary from .plist named: \(fileName)")
        }
        return dictionary
    }
    
    public static func parseResourceFile<T: Decodable>(named fileName: String, withExtension fileExtension: String? = nil) -> T? {
        do {
            let data = resourceData(named: fileName, withExtension: fileExtension)!
            let decoder = PropertyListDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    private static func resourceData(named resourceFileName: String, withExtension fileExtension: String? = nil) -> Data? {
        guard let dataURL = Bundle.main.url(forResource: resourceFileName, withExtension: fileExtension) else {
            debugPrint("File not found: \(resourceFileName)", inCase: [.resources])
            return nil
        }
        return try? Data(contentsOf: dataURL)
    }
}
