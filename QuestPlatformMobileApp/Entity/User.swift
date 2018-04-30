//
//  User.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class User: Codable {
    var id: EntityIdentifier?
    var name: String?
    var email: String
    var avatar: String?
    
    init(id: EntityIdentifier? = nil, name: String?, email: String, avatar: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
    }
}
