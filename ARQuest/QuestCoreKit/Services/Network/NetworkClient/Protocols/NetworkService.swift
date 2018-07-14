//
//  NetworkService.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol NetworkService: class {
    var client: NetworkClient { get }
    var session: SessionStorage { get }
    init(client: NetworkClient, session: SessionStorage)
}
