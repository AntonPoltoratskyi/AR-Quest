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
    case userNotFound
    case unknownError
    case jsonDecodingError(Error)
}

extension APIError: ErrorRepresentable {
    var errorMessage: String {
        switch self {
        case .userNotFound:
            return "Invalid credentials"
        default:
            return "Something went wrong"
        }
    }
}
