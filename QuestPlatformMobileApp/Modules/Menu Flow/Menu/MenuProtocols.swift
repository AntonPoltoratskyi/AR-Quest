//
//  MenuProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol MenuModuleInput: ModuleInput {
}

// MARK: - View

protocol MenuViewInput: class {
}

// MARK: -
protocol MenuViewOutput: class {
    func showProfile()
    func showMyQuests()
    func startNewQuest()
    func showAbout()
    func logout()
}

// MARK: - Interactor

protocol MenuInteractorInput: class {
    func logout()
}

// MARK: -
protocol MenuInteractorOutput: class {
    func didLogout()
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol MenuRouterInput: class {
    func showProfile()
    func showMyQuests()
    func startNewQuest()
    func showAbout()
    func performLogout()
}
