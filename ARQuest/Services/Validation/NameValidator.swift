//
//  NameValidator.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 06.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct NameValidator: Validator {
    typealias Input = String
    
    func validated(_ input: Input?) throws -> Input {
        guard let input = input else {
            throw ValidationError.invalidPassword
        }
        if input.trimmingCharacters(in: .whitespacesAndNewlines).count >= 1 {
            return input
        }
        throw ValidationError.invalidPassword
    }
}
