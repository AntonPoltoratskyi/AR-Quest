//
//  AuthNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum AuthNetworkRouter: URLRequestConvertible {
    case login(credentials: LoginCredentials)
    case register(credentials: SignUpCredentials)
    case logout(token: String?)
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .logout:
            return "logout"
        }
    }
    
    var method: String {
        return "POST"
    }
    
    func asURLRequest() -> URLRequest {
        notImplemented()
    }
}
