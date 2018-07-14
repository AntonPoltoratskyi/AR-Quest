//
//  TaskBuilderProtocols.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol TaskBuilderModuleInput: ModuleInput {
    var output: TaskBuilderModuleOutput? { get set }
    func dismiss()
}

protocol TaskBuilderModuleOutput: class {
    func taskBuilderModule(_ moduleInput: TaskBuilderModuleInput, didCreateTask task: Task)
}

// MARK: - View

protocol TaskBuilderViewInput: class {
    func setupSelectedLocation(_ coordinate: Coordinate)
}

// MARK: -
protocol TaskBuilderViewOutput: class {
    func didTapDone(title: String?, text: String?)
    func didTapSelectLocation()
}

// MARK: - Interactor

protocol TaskBuilderInteractorInput: class {
}

// MARK: -
protocol TaskBuilderInteractorOutput: class {
}

// MARK: - Router

protocol TaskBuilderRouterInput: class {
    func dismiss()
    func showLocationPicker(delegate: LocationPickerModuleOutput)
}
