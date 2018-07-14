//
//  OwnQuestsProtocols.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol OwnQuestsModuleInput: ModuleInput {
}

// MARK: - View

protocol OwnQuestsViewInput: class {
    func setupQuests(_ models: [QuestCellModel])
}

// MARK: -
protocol OwnQuestsViewOutput: class {
    func viewDidLoad()
    func didSelectQuest(_ questModel: QuestCellModel)
}

// MARK: - Interactor

protocol OwnQuestsInteractorInput: class {
    func loadQuests()
}

// MARK: -
protocol OwnQuestsInteractorOutput: LoadingRepresentable {
    func didLoadQuests(_ quests: [Quest])
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol OwnQuestsRouterInput: class {
    func showQuest(_ quest: Quest)
}
