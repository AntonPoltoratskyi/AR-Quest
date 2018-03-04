//
//  NetworkService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol NetworkService: class {
    var networkClient: NetworkClient { get }
    init(networkClient: NetworkClient)
}
