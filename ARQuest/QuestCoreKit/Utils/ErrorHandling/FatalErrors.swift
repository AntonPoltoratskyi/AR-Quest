//
//  FatalErrors.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/11/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public func abstractImplementation(file: String = #file, function: String = #function) -> Never {
    fatalError("\(file):\(function) not implemened: abstract implementation")
}

public func notImplemented(file: String = #file, function: String = #function) -> Never {
    fatalError("\(file):\(function) not implemened")
}
