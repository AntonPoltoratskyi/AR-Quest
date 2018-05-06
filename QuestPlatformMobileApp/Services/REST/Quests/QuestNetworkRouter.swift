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
    case ownList(token: String?)
    case tasks(quest: Quest, token: String?)
    case joinBy(code: String, token: String?)
    case joinTo(quest: Quest, token: String?)
    case create(quest: Quest, token: String?)
    
    var path: String {
        switch self {
        case .list:
            return "list"
        case .ownList:
            return "list/own"
        case .tasks:
            return "tasks"
        case .joinBy:
            return "join"
        case .joinTo:
            return "join"
        case .create:
            return "create"
        }
    }
    
    var method: String {
        return "POST"
    }
    
    func asURLRequest() throws -> URLRequest {
        notImplemented()
    }
}
