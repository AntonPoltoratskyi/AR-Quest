//
//  UserNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum UserNetworkRouter: URLRequestConvertible {
    case getCurrentUser(token: String?)
    case edit(user: User, token: String?)
    
    var path: String {
        switch self {
        case .getCurrentUser:
            return "me"
        case .edit:
            return "edit"
        }
    }
    
    var method: String {
        return "POST"
    }
    
    func asURLRequest() -> URLRequest {
        notImplemented()
    }
}
