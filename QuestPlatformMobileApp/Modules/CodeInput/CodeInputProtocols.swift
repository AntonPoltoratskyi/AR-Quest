//
//  CodeInputProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol CodeInputModuleInput: ModuleInput {
}

// MARK: - View

protocol CodeInputViewInput: class {
    func showError(_ errorMessage: String)
}

// MARK: -
protocol CodeInputViewOutput: class {
    func didClickJoin(to questCode: String?)
}

// MARK: - Interactor

protocol CodeInputInteractorInput: class {
    func join(to questCode: String)
}

// MARK: -
protocol CodeInputInteractorOutput: LoadingRepresentable {
    func didJoin(to quest: Quest)
    func didReceiveError(_ error: Error)
}

// MARK: - Router

protocol CodeInputRouterInput: class {
    func join(to quest: Quest)
}
