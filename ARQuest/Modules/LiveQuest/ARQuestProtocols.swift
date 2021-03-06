//
//  ARQuestProtocols.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

// MARK: - Module Input

protocol ARQuestModuleInput: ModuleInput {
}

// MARK: - View

protocol ARQuestViewInput: class {
    var sceneView: ARSCNView { get }
    
    func showDebugMessage(_ message: String)
    func showSceneState(_ state: ARSceneViewState)
    
    // Quest
    func showDistance(_ distance: Distance)
    func showLocationSearch()
    
    func showTaskName(_ name: String)
    func showTextPopup(_ text: String)
    
    func enableNextAction()
    func disableNextButton()
}

// MARK: -
protocol ARQuestViewOutput: class {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    
    func didHideTextPopup()
    func didClickNextButton()
}

// MARK: - Interactor

protocol ARQuestInteractorInput: class {
    func startLocationUpdates()
    func stopLocationUpdates()
}

// MARK: -
protocol ARQuestInteractorOutput: class {
    func didChangeLocationAuthorizationStatus(_ status: CLAuthorizationStatus)
    func didUpdateLocation(_ newLocation: CLLocation, previousLocation: CLLocation?)
    func didUpdateHeading(_ newHeading: CLHeading)
    func didReceiveLocationFailure(_ error: Error)
}

// MARK: - Router

protocol ARQuestRouterInput: class {
    func showFinish(for quest: Quest)
}
