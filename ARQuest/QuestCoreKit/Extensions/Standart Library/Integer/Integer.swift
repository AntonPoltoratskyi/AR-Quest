//
//  Int.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/24/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension SignedInteger {
    var boolValue: Bool {
        return self == 0 ? false : true
    }
}

extension UnsignedInteger {
    var boolValue: Bool {
        return self == 0 ? false : true
    }
}
