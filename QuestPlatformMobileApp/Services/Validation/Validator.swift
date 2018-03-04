//
//  Validator.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 03.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol Validator {
    associatedtype Input
    func validated(_ input: Input?) throws -> Input
}

enum ValidationError: Error, ErrorRepresentable {
    case invalidEmail
    case invalidPassword
    case passwordNotMatch
    
    var errorMessage: String {
        switch self {
        case .invalidEmail:
            return "Invalid email"
        case .invalidPassword:
            return "Invalid password"
        case .passwordNotMatch:
            return "Password doesn't match"
        }
    }
}

protocol ErrorRepresentable {
    var errorMessage: String { get }
}
