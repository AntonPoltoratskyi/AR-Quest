//
//  SplashInteractor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol SplashInteractorInput: class {
}

protocol SplashInteractorOutput: class {
}

final class SplashInteractor: Interactor, SplashInteractorInput {
    typealias Output = SplashInteractorOutput
    weak var output: Output!
}
