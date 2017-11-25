//
//  FatalErrors.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/11/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public func abstractImplementation(function: String = #function) -> Never {
    fatalError("\(function) not implemened: abstract implementation")
}

public func notImplemented(function: String = #function) -> Never {
    fatalError("\(function) not implemened")
}

public func unableToCreate(_ type: Any.Type) -> Never {
    fatalError("Unable to create \(String(describing: type))")
}
