//
//  QuestCreationResponse.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct QuestCreationResponse: Codable {
    let quest: Quest
    let code: String
}
