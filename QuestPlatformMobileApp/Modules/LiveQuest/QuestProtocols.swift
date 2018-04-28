//
//  QuestProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

// MARK: - Module Input

protocol QuestModuleInput: ModuleInput {
}

// MARK: - View

protocol QuestViewInput: class {
    var sceneView: ARSCNView { get }
    func showMessage(_ message: String)
}

// MARK: -
protocol QuestViewOutput: class {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
}

// MARK: - Interactor

protocol QuestInteractorInput: class {
    func startLocationUpdates()
    func stopLocationUpdates()
}

// MARK: -
protocol QuestInteractorOutput: class {
    func handleUpdatedLocation(_ newLocation: CLLocation, previousLocation: CLLocation?)
    func handleUpdatedHeading(_ newHeading: CLHeading)
    func handleLocationUpdateFailure(_ error: Error)
}

// MARK: - Router

protocol QuestRouterInput: class {
}
