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
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/signup"
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var params: HTTPParameters {
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
    
    var headers: HTTPHeaders {
        switch self {
        case .login, .register:
            return [:]
        case let .logout(token):
            return token.map { HTTPHeaders.authorization($0) } ?? [:]
        }
    }
}
