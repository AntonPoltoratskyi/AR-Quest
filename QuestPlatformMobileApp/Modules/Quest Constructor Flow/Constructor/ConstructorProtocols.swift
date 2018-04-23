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
}

// MARK: - Interactor

protocol ConstructorInteractorInput: class {
}

// MARK: -
protocol ConstructorInteractorOutput: class {
}

// MARK: - Router

protocol ConstructorRouterInput: class {
    func showTaskCreator()
}

protocol ConstructorRouterOutput: class {
    func didCreateTask(_ task: Task)
}
