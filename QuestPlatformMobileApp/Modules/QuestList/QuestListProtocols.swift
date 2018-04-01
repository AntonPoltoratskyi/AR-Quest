//
//  QuestListProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol QuestListModuleInput: ModuleInput {
}

// MARK: - View

protocol QuestListViewInput: class {
    func setupQuests(_ models: [QuestCellModel])
}

// MARK: -
protocol QuestListViewOutput: class {
    func viewDidLoad()
    func didSelectQuest(_ questModel: QuestCellModel)
}

// MARK: - Interactor

protocol QuestListInteractorInput: class {
    func loadQuests()
}

// MARK: -
protocol QuestListInteractorOutput: class {
    func didLoadQuests(_ quests: [Quest])
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol QuestListRouterInput: class {
    func showQuest(_ quest: Quest)
    func showCodeJoin()
}
