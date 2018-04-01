//
//  QuestDetailsProtocols.swift
//  QuestPlatformMobileApp
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
    
}

// MARK: -
protocol QuestDetailsViewOutput: class {
    func viewDidLoad()
}

// MARK: - Interactor

protocol QuestDetailsInteractorInput: class {
    func loadTasks(for quest: Quest)
}

// MARK: -
protocol QuestDetailsInteractorOutput: class {
    func didLoadTasks(_ tasks: [Task])
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol QuestDetailsRouterInput: class {
}
