//
//  Quest.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class Quest: Codable {
    enum Status: Int, Codable {
        case waiting = 1
        case active  = 2
        case closed  = 3
    }
    enum AccessLevel: Int, Codable {
        case `public`  = 1
        case `private` = 2
    }
    
    var id: EntityIdentifier?
    var name: String
    var status: Status
    var accessLevel: AccessLevel
    var owner: User
    
    init(id: EntityIdentifier? = nil, name: String, status: Status, accessLevel: AccessLevel, owner: User) {
        self.id = id
        self.name = name
        self.status = status
        self.accessLevel = accessLevel
        self.owner = owner
    }
}
