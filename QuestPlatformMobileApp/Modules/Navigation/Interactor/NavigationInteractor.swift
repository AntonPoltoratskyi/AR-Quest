//
//  NavigationInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol NavigationInteractorInput: class {
}

protocol NavigationInteractorOutput: class {
}

final class NavigationInteractor: Interactor, NavigationInteractorInput {
    typealias Output = NavigationInteractorOutput
    weak var output: NavigationInteractorOutput!
}
