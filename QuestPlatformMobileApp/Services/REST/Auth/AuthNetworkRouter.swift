//
//  AuthNetworkRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum AuthNetworkRouter: NetworkRouter {
    case login(credentials: LoginCredentials)
    case register(credentials: SignUpCredentials)
    case logout(token: String?)
    
    static let baseURL = URL(string: "http://localhost:8080/auth")!
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "signup"
        case .logout:
            return "logout"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var params: [String: String] {
        switch self {
        case let .login(credentials):
            return [
                "email": credentials.email,
                "password": credentials.password
            ]
        case let .register(credentials):
            return [
                "name": credentials.name,
                "email": credentials.email,
                "password": credentials.password
            ]
        case .logout:
            return [:]
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .login, .register:
            return [:]
        case let .logout(token):
            if let token = token {
                return ["Authorization": "Bearer \(token)"]
            }
            return [:]
        }
    }
}
