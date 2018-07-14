//
//  CodeValidator.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 07.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct CodeValidator: Validator {
    typealias Input = String
    
    func validated(_ input: Input?) throws -> Input {
        guard let input = input else {
            throw ValidationError.invalidCode
        }
        if input.trimmingCharacters(in: .whitespacesAndNewlines).count >= 6 {
            return input
        }
        throw ValidationError.invalidCode
    }
}
