//
//  LoginInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol LoginInteractorInput: class {
}

protocol LoginInteractorOutput: class {
}

final class LoginInteractor: Interactor, LoginInteractorInput {
    typealias Output = LoginInteractorOutput
    weak var output: LoginInteractorOutput!
}
