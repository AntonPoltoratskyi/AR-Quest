//
//  Assembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol Assembly: class {
    associatedtype ModuleInput
    static func build() -> ModuleInput
}
