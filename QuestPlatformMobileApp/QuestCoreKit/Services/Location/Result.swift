//
//  Result.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.11.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
