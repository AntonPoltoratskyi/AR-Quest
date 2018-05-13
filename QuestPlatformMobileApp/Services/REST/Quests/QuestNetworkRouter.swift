//
//  QuestNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum QuestNetworkRouter: NetworkRouter {
    case create(quest: Quest, token: String?)
    case questList(token: String?)
    case ownQuestList(token: String?)
    case joinToQuest(quest: Quest, token: String?)
    case joinByCode(code: String, token: String?)
    case tasks(quest: Quest, token: String?)
    
    var path: String {
        switch self {
        case .create:
            return "/quest/"
        case .questList:
            return "/quest/all"
        case .ownQuestList:
            return "/quest/own"
        case let .joinToQuest(quest, _):
            guard let id = quest.id else {
                fatalError("Quest must != nil")
            }
            return "/quest/join/\(id)"
        case .joinByCode:
            return "/quest/join/code"
        case let .tasks(quest, _):
            guard let id = quest.id else {
                fatalError("Quest must != nil")
            }
            return "/quest\(id)/tasks"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create, .joinByCode, .joinToQuest:
            return .post
        case .questList, .ownQuestList, .tasks:
            return .get
        }
    }
    
    var params: HTTPParameters {
        switch self {
        case let .create(quest, _):
            return [
                "name": quest.name,
                "status": quest.status.rawValue,
                "accessLevel": quest.accessLevel.rawValue,
                "tasks": quest.tasks.map {
                    [
                        "title": $0.title,
                        "latitude": $0.latitude as Any,
                        "longitude": $0.longitude as Any,
                        "text": $0.text as Any
                    ]
                }
            ]
        case let .joinByCode(code, _):
            return ["code": code]
        case .questList, .ownQuestList, .joinToQuest, .tasks:
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        let headers: HTTPHeaders?
        switch self {
        case let .create(_, token):
            headers = token.map { HTTPHeaders.authorization($0) }
        case let .questList(token):
            headers = token.map { HTTPHeaders.authorization($0) }
        case let .ownQuestList(token):
            headers = token.map { HTTPHeaders.authorization($0) }
        case let .tasks(_, token):
            headers = token.map { HTTPHeaders.authorization($0) }
        case let .joinToQuest(_, token):
            headers = token.map { HTTPHeaders.authorization($0) }
        case let .joinByCode(_, token):
            headers = token.map { HTTPHeaders.authorization($0) }
        }
        return headers ?? [:]
    }
}
