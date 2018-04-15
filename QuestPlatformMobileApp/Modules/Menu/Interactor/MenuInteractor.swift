//
//  MenuInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class MenuInteractor: Interactor, MenuInteractorInput {
    typealias Output = MenuInteractorOutput
    weak var output: MenuInteractorOutput!
}
