//
//  ARQuestPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MapKit

final class ARQuestPresenter: Presenter, ARQuestModuleInput {
    
    typealias View = ARQuestViewInput
    typealias Interactor = ARQuestInteractorInput
    typealias Router = ARQuestRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    private let trackingService: ARTrackingServiceInput
    
    private var sceneHandler: ARSceneViewModelInput!
    
    private let quest: Quest
    
    /// Update it only on main queue
    private var currentTask: Task? {
        didSet {
            guard let task = currentTask else {
                handleQuestFinish()
                return
            }
            switch task.goal {
            case let .text(text):
                showMessage(text)
                view.enableNextAction()
            case let .location(destinationCoordinate):
                updateDestinationNodePosition(for: destinationCoordinate)
            }
        }
    }
    
    private let distanceFormatter = LengthFormatter()
    
    private var isTextPopupPresented = false
    private var isFinished = false
    
    
    // MARK: - Init
    
    init(quest: Quest, trackingService: ARTrackingServiceInput) {
        self.quest = quest
        self.trackingService = trackingService
    }
    
    deinit {
        deinited(self)
    }
}

// MARK: - ARQuestViewOutput
extension ARQuestPresenter: ARQuestViewOutput {
    
    func viewDidLoad() {
        view.disableNextButton()
        
        let handler = ARSceneViewModel(with: view.sceneView)
        handler.delegate = self
        sceneHandler = handler
        
        currentTask = quest.tasks?.first
        
        interactor.startLocationUpdates()
    }
    
    func viewDidAppear() {
        sceneHandler.launchSession()
    }
    
    func viewDidDisappear() {
        sceneHandler.pauseSession()
    }
    
    func didHideTextPopup() {
        view.disableNextButton()
        isTextPopupPresented = false
        goToNextTask()
    }
    
    private func goToNextTask() {
        currentTask = quest.tasks?.next(after: { $0 === currentTask })
    }
}


// MARK: - ARQuestInteractorOutput
extension ARQuestPresenter: ARQuestInteractorOutput {
    
    func didChangeLocationAuthorizationStatus(_ status: CLAuthorizationStatus) { }
    
    func didUpdateHeading(_ newHeading: CLHeading) { }
    
    func didUpdateLocation(_ newLocation: CLLocation, previousLocation: CLLocation?) {
        sceneHandler.cameraTransform.map {
            trackingService.update(location: newLocation, camera: $0)
        }
    }
    
    func didReceiveLocationFailure(_ error: Error) {
        DispatchQueue.main.async {
            self.view.showDebugMessage(error.localizedDescription)
        }
    }
}

// MARK: - ARSceneViewModelDelegate
extension ARQuestPresenter: ARSceneViewModelDelegate {
    
    func sceneViewModel(_ sceneModel: ARSceneViewModel, didUpdateState state: ARSceneViewState) {
        view.showSceneState(state)
    }
}

// MARK: - ARTrackingServiceDelegate
extension ARQuestPresenter: ARTrackingServiceDelegate {
    
    func sessionDidUpdate(with trackingInfo: TrackingInfo) {
        DispatchQueue.main.async {
            let accuracy = trackingInfo.accuracy()
            let message = self.distanceFormatter.string(fromMeters: accuracy)
            self.view.showDebugMessage(message)
            
            guard accuracy <= 1 && accuracy >= 0.0001 else {
                return
            }
            
            guard let currentTask = self.currentTask, case let .location(destinationCoordinate) = currentTask.goal else {
                return
            }
            self.updateDestinationNodePosition(for: destinationCoordinate)
        }
    }
    
    func sessionDidStartTracking() {
    }
    
    func sessionDidBecomeInvalid() {
        DispatchQueue.main.async {
            self.removeDestinationNode()
            self.sceneHandler.reloadSession()
        }
    }
}

// MARK: - User Events
extension ARQuestPresenter {
    
    private func handleQuestFinish() {
        guard !isFinished else { return }
        isFinished = true
        
        view.disableNextButton()
        router.showFinish(for: quest)
    }
    
    private func showMessage(_ text: String) {
        guard !isTextPopupPresented else { return }
        isTextPopupPresented = true
        
        removeDestinationNode()
        view.enableNextAction()
        view.showTextPopup(text)
    }
    
    private func handleDistanceToDestination(_ distance: Distance) {
        view.showDistance(distance)
        if distance < ARConstants.destinationDistance {
            goToNextTask()
        }
    }
}

// MARK: - Nodes
extension ARQuestPresenter {
    
    private func updateDestinationNodePosition(for location: Coordinate) {
        guard let camera = sceneHandler?.cameraTransform,
            let currentLocation = trackingService.lastRecognizedLocation else {
                return
        }
        let identifier = "destination-location"
        
        var existingNodes: [DestinationNode] = view.sceneView.scene.rootNode.childNodes {
            $0.identifier == identifier
        }
        if existingNodes.isEmpty {
            let destinationNode = DestinationNode(coordinate: location, identifier: identifier)
            view.sceneView.scene.rootNode.addChildNode(destinationNode)
            existingNodes.append(destinationNode)
        }
        
        for node in existingNodes {
            node.update(with: camera, currentCoordinates: currentLocation.coordinate, thresholdDistance: ARConstants.sceneRadius)
        }
        
        let estimatedFloorHeight = sceneHandler.estimatedHeight()
        SCNTransaction.animate(withDuration: 0.25, animations: {
            for node in existingNodes {
                let distance = currentLocation.coordinate.distance(to: location)
                let sceneDistance = distance > ARConstants.sceneRadius ? ARConstants.sceneRadius : distance
                
                node.applyScale(self.scaleForDistance(sceneDistance))
                node.applyHeight(self.heightForDistance(distance, floorHeight: estimatedFloorHeight))
                
                self.handleDistanceToDestination(distance)
            }
        })
    }
    
    private func removeDestinationNode() {
        let nodes: [DestinationNode] = view.sceneView.scene.rootNode.childNodes {
            $0.identifier == "destination-location"
        }
        for node in nodes {
            node.removeFromParentNode()
        }
    }
    
    private func heightForDistance(_ distance: Double, floorHeight: Float) -> Float {
        if distance < 10 {
            return 1 + Float(distance) + floorHeight
        }
        return 10 + floorHeight
    }
    
    private func scaleForDistance(_ distance: Double) -> Float {
        var scale = Float(distance) * 0.3
        if scale < 2 {
            scale = 2
        }
        return scale
    }
}
