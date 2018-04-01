//
//  QuestNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum QuestNetworkRouter: URLRequestConvertible {
    case list(token: String?)
    case tasks(quest: Quest, token: String?)
    
    var path: String {
        switch self {
        case .list:
            return "list"
        case .tasks:
            return "tasks"
        }
    }
    
    var method: String {
        return "POST"
    }
    
    func asURLRequest() -> URLRequest {
        notImplemented()
    }
}
