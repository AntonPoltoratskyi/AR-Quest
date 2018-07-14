//
//  AuthResponse.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 06.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct AuthResponse: Codable {
    let user: User
    let token: String
}
