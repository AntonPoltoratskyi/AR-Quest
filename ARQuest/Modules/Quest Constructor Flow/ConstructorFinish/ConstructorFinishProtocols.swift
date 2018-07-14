//
//  ConstructorFinishProtocols.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol ConstructorFinishModuleInput: ModuleInput {
}

// MARK: - View

protocol ConstructorFinishViewInput: class {
    func setupCode(_ code: String)
}

// MARK: -
protocol ConstructorFinishViewOutput: class {
    func viewDidLoad()
    func didTapDoneButton()
}

// MARK: - Interactor

protocol ConstructorFinishInteractorInput: class {
}

// MARK: -
protocol ConstructorFinishInteractorOutput: class {
}

// MARK: - Router

protocol ConstructorFinishRouterInput: class {
    func finish()
}
