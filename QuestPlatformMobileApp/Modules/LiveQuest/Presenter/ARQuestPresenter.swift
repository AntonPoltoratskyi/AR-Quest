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
    
    private var sceneHandler: ARSceneViewModelInput!
    
    private let trackingService: ARTrackingService = {
        let service = ARTrackingService()
        return service
    }()
    
    private let quest: Quest
    
    /// Update it only on main queue
    private var currentTask: Task? {
        didSet {
            guard let task = currentTask else {
                handleQuestFinish()
                return
            }
            switch task.goal {
            case let .hint(text):
                if !isTextPopupPresented {
                    showHint(text)
                    view.enableNextAction()
                }
            case let .location(destinationCoordinate):
                updateDestinationNodePosition(for: destinationCoordinate)
            }
        }
    }
    
    private let updateQueue = DispatchQueue.queue(for: ARQuestPresenter.self)
    
    private let distanceFormatter = LengthFormatter()
    
    private var isTextPopupPresented = false
    private var isFinished = false
    
    
    // MARK: - Init
    
    init(quest: Quest) {
        self.quest = quest
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
        
        self.currentTask = quest.tasks.first
        
        trackingService.delegate = self
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
        updateQueue.sync {
            self.isTextPopupPresented = false
        }
        goToNextTask()
    }
    
    private func goToNextTask() {
        currentTask = quest.tasks.next(after: { $0 === currentTask })
    }
}


// MARK: - ARQuestInteractorOutput
extension ARQuestPresenter: ARQuestInteractorOutput {
    
    func didChangeLocationAuthorizationStatus(_ status: CLAuthorizationStatus) {
    }
    
    func didUpdateHeading(_ newHeading: CLHeading) {
    }
    
    func didUpdateLocation(_ newLocation: CLLocation, previousLocation: CLLocation?) {
        guard let cameraTransform = sceneHandler.currentCameraTransform() else { return }
        trackingService.handleLocationUpdate(newLocation: newLocation, currentCameraTransform: cameraTransform)
    }
    
    func didReceiveLocationFailure(_ error: Error) {
        view.showMessage(error.localizedDescription)
    }
}

// MARK: - ARSceneViewModelDelegate
extension ARQuestPresenter: ARSceneViewModelDelegate {
    
    func sceneViewModel(_ sceneModel: ARSceneViewModel, didUpdateState state: ARSceneViewState) {
        switch state {
        case .normal, .normalEmptyAnchors:
            break
        default:
            break
        }
    }
}

// MARK: - Task Actions
extension ARQuestPresenter {
    
    private func handleQuestFinish() {
        updateQueue.async {
            guard !self.isFinished else { return }
            self.isFinished = true
            
            DispatchQueue.main.async {
                self.view.disableNextButton()
                self.router.showFinish(for: self.quest)
            }
        }
    }
    
    private func showHint(_ text: String) {
        updateQueue.async {
            guard !self.isTextPopupPresented else { return }
            self.isTextPopupPresented = true
            
            DispatchQueue.main.async {
                self.removeDestinationNode()
                self.view.enableNextAction()
                self.view.showTextPopup(text)
            }
        }
    }
    
    private func handleDistanceToDestination(_ distance: Distance) {
        updateQueue.async {
            DispatchQueue.main.async {
                self.view.showDistance(distance)
                if distance < 5 {
                    self.goToNextTask()
                }
            }
        }
    }
}

// MARK: - ARTrackingServiceDelegate
extension ARQuestPresenter: ARTrackingServiceDelegate {
    
    func didUpdateTrackedPosition(with trackingInfo: TrackingInfo) {
        DispatchQueue.main.async {
            let accuracy = trackingInfo.accuracy()
            self.view.showMessage(self.distanceFormatter.string(fromMeters: accuracy))
            
            if accuracy <= 1 && accuracy >= 0.0001 {
                guard let currentTask = self.currentTask, case let .location(destinationCoordinate) = currentTask.goal else {
                    return
                }
                self.updateDestinationNodePosition(for: destinationCoordinate)
            }
        }
    }
    
    func didStartPositionTracking() {
    }
    
    func handleARSessionReset() {
        removeDestinationNode()
        sceneHandler.reloadSession()
    }
}

// MARK: - Nodes

extension ARQuestPresenter {
    
    private func updateDestinationNodePosition(for location: Coordinate) {
        guard let camera = sceneHandler?.currentCameraTransform(),
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
            node.update(with: camera, currentCoordinates: currentLocation.coordinate, thresholdDistance: SceneUtils.sceneRadius)
        }
        
        let estimatedFloorHeight = sceneHandler.estimatedHeight()
        SCNTransaction.animate(withDuration: 0.25, animations: {
            for node in existingNodes {
                let distance = currentLocation.coordinate.distance(to: location)
                let sceneDistance = distance > SceneUtils.sceneRadius ? SceneUtils.sceneRadius : distance
                
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
