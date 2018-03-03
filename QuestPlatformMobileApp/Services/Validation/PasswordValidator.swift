//
//  PasswordValidator.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 03.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct PasswordValidator: Validator {
    typealias Input = String
    
    func validated(_ input: Input?) throws -> Input {
        guard let input = input else {
            throw ValidationError.invalidPassword
        }
        if input.trimmingCharacters(in: .whitespacesAndNewlines).count >= 6 {
            return input
        }
        throw ValidationError.invalidPassword
    }
}
