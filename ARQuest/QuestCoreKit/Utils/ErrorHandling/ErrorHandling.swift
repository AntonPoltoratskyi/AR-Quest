//
//  ErrorHandling.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 11/1/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

func process<E: Error>(_ block: () throws -> Void, orThrow defaultError: E) rethrows {
    do {
        try block()
    } catch {
        throw defaultError
    }
}
