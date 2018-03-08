//
//  MainInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol MainInteractorInput: class {
}

protocol MainInteractorOutput: class {
}

final class MainInteractor: Interactor, MainInteractorInput {
    typealias Output = MainInteractorOutput
    weak var output: MainInteractorOutput!
}
