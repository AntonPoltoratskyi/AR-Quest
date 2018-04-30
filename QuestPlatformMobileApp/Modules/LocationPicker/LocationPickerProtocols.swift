//
//  LocationPickerProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Module Input

protocol LocationPickerModuleInput: ModuleInput {
}

protocol LocationPickerModuleOutput: ModuleInput {
    func didSelectLocation(at coordinate: Coordinate)
}

// MARK: - View

protocol LocationPickerViewInput: class {
}

// MARK: -
protocol LocationPickerViewOutput: class {
    func didSelectCoordinate(_ coordinate: Coordinate)
    func didClickDone()
    func didClickCancel()
}

// MARK: - Interactor

protocol LocationPickerInteractorInput: class {
}

// MARK: -
protocol LocationPickerInteractorOutput: class {
}

// MARK: - Router

protocol LocationPickerRouterInput: Router {
    func finish()
}
