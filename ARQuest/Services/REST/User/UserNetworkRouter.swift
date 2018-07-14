//
//  UserNetworkRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum UserNetworkRouter: NetworkRouter {
    case getCurrentUser(token: String?)
    case edit(user: User, token: String?)
    
    var path: String {
        switch self {
        case .getCurrentUser:
            return "/user"
        case .edit:
            return "/user"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentUser:
            return .get
        case .edit:
            return .put
        }
    }
    
    var params: HTTPParameters {
        switch self {
        case .getCurrentUser:
            return [:]
        case let .edit(user, _):
            if let name = user.name {
                return ["name": name]
            }
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getCurrentUser:
            return [:]
        case let .edit(_, token):
            return token.map { HTTPHeaders.authorization($0) } ?? [:]
        }
    }
}
