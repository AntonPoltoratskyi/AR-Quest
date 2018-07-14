//
//  EmailValidator.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 03.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct EmailValidator: Validator {
    private static let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    typealias Input = String
    
    func validated(_ input: Input?) throws -> Input {
        guard let input = input else {
            throw ValidationError.invalidEmail
        }
        let emailTest = NSPredicate(format:"SELF MATCHES %@", type(of: self).pattern)
        if emailTest.evaluate(with: input) {
            return input
        }
        throw ValidationError.invalidEmail
    }
}
