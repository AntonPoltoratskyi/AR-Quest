//
//  MenuInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol MenuInteractorInput: class {
}

protocol MenuInteractorOutput: class {
}

final class MenuInteractor: Interactor, MenuInteractorInput {
    typealias Output = MenuInteractorOutput
    weak var output: MenuInteractorOutput!
}
