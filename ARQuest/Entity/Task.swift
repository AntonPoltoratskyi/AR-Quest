//
//  Task.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class Task: Codable {
    var id: EntityIdentifier?
    var title: String
    
    enum Goal {
        case location(Coordinate)
        case text(String)
    }
    var goal: Goal
    
    init(id: EntityIdentifier? = nil, name: String, goal: Goal) {
        self.id = id
        self.title = name
        self.goal = goal
    }
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case title      = "title"
        case latitude   = "latitude"
        case longitude  = "longitude"
        case text       = "text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(EntityIdentifier.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        let latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        let longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        let text = try container.decodeIfPresent(String.self, forKey: .text)
        
        if let lat = latitude, let lng = longitude {
            let coordinate = Coordinate(latitude: lat, longitude: lng)
            goal = .location(coordinate)
        } else {
            goal = .text(text ?? "")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let id = id {
            try container.encode(id, forKey: .id)
        }
        try container.encode(title, forKey: .title)
        
        switch goal {
        case let .location(coordinate):
            try container.encode(coordinate.latitude, forKey: .latitude)
            try container.encode(coordinate.longitude, forKey: .longitude)
        case let .text(text):
            try container.encode(text, forKey: .text)
        }
    }
}

extension Task {
    
    var latitude: Double? {
        guard case let .location(coordinate) = goal else {
            return nil
        }
        return coordinate.latitude
    }
    
    var longitude: Double? {
        guard case let .location(coordinate) = goal else {
            return nil
        }
        return coordinate.longitude
    }
    
    var text: String? {
        guard case let .text(text) = goal else {
            return nil
        }
        return text
    }
}
