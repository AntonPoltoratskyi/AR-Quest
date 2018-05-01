//
//  ConstructorProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol ConstructorModuleInput: ModuleInput {
}

// MARK: - View

protocol ConstructorViewInput: class {
    func addTask(_ task: Task)
}

// MARK: -
protocol ConstructorViewOutput: class {
    func didClickAddTask()
    func didClickDone()
}

// MARK: - Interactor

protocol ConstructorInteractorInput: class {
    func create(_ quest: Quest)
}

// MARK: -
protocol ConstructorInteractorOutput: class {
    func didCreate(_ quest: Quest, withCode code: String)
    func didReceiveFailure(_ error: Error)
}

// MARK: - Router

protocol ConstructorRouterInput: class {
    func showTaskCreator()
    func showQuestInfoPopup()
    func showConstructorFinish(for quest: Quest, code: String)
}

protocol ConstructorRouterOutput: class {
    func didCreateTask(_ task: Task)
}
