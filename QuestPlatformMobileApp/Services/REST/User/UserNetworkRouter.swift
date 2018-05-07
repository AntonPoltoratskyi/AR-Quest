//
//  UserNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum UserNetworkRouter: NetworkRouter {
    case getCurrentUser(token: String?)
    case edit(user: User, token: String?)
    
    static let baseURL = URL(string: "http://localhost:8080/user")!
    
    var path: String {
        switch self {
        case .getCurrentUser:
            return "me"
        case .edit:
            return "edit"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var params: [String : String] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
