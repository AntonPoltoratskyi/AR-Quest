//
//  APIError.swift
//  Components
//
//  Created by Anton Poltoratskyi on 29.01.18.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidToken
    case invalidCredentials
    case invalidInput
    case userNotFound
    case questNotFound
    case unknownError
    case jsonDecodingError(Error)
}

extension APIError: ErrorRepresentable {
    var errorMessage: String {
        switch self {
        case .invalidToken:
            return "Invalid token"
        case .invalidCredentials:
            return "Invalid_credentials"
        case .invalidInput:
            return "Invalid input"
        case .userNotFound:
            return "User not found"
        case .questNotFound:
            return "Quest not found"
        default:
            return "Something went wrong"
        }
    }
}
