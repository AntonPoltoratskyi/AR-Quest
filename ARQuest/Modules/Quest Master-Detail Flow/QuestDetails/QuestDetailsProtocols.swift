//
//  QuestDetailsProtocols.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol QuestDetailsModuleInput: ModuleInput {
}

// MARK: - View

protocol QuestDetailsViewInput: class {
    func setupQuestInfo(_ quest: Quest)
    func setupTasks(_ models: [QuestTaskCellModel])
}

// MARK: -
protocol QuestDetailsViewOutput: class {
    func viewDidLoad()
    func didClickJoin()
}

// MARK: - Interactor

protocol QuestDetailsInteractorInput: class {
    func loadTasks(for quest: Quest)
    func join(to quest: Quest)
}

// MARK: -
protocol QuestDetailsInteractorOutput: LoadingRepresentable {
    func didLoadTasks(_ tasks: [Task])
    func didJoin(to quest: Quest)
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol QuestDetailsRouterInput: class {
    func join(to quest: Quest)
}
