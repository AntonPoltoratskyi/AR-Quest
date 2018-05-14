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
        case created = 0
        case active  = 1
        case closed  = 2
    }
    enum AccessLevel: Int, Codable {
        case `public`  = 0
        case `private` = 1
    }
    
    var id: EntityIdentifier?
    var name: String
    var status: Status
    var accessLevel: AccessLevel
    var tasks: [Task]
    var owner: User
    
    init(id: EntityIdentifier? = nil, name: String, status: Status, accessLevel: AccessLevel, tasks: [Task], owner: User) {
        self.id = id
        self.name = name
        self.status = status
        self.accessLevel = accessLevel
        self.tasks = tasks
        self.owner = owner
    }
}
