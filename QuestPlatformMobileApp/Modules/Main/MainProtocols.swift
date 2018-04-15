//
//  MainProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol MainModuleInput: ModuleInput {
}

// MARK: - View

protocol MainViewInput: class {
    func setup(_ viewModel: MainViewModel)
}

// MARK: -
protocol MainViewOutput: class {
    func viewDidLoad()
    func didClickJoin()
    func didClickMenu()
    func didClickSearch()
    func didClickProfile()
}

// MARK: - Interactor

protocol MainInteractorInput: class {
    func loadQuests()
}

// MARK: -
protocol MainInteractorOutput: class {
    func didLoadQuestCount(_ count: Int)
}

// MARK: - Router

protocol MainRouterInput: class {
    func showQuestList()
    func showMenu()
}
