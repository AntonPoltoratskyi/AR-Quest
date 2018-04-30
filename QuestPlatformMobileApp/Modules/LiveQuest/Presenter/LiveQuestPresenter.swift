//
//  LiveQuestPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MapKit

final class LiveQuestPresenter: Presenter, QuestModuleInput {
    
    typealias View = QuestViewInput
    typealias Interactor = QuestInteractorInput
    typealias Router = QuestRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    private var destinationCoordinate: Coordinate
    
    private var sceneHandler: ARSceneViewModelInput!
    
    private let trackingService: ARTrackingService = {
        let service = ARTrackingService()
        return service
    }()
    
    
    // MARK: - Init
    
    init(destination: Coordinate) {
        self.destinationCoordinate = destination
    }
    
    deinit {
        deinited(self)
    }
}

// MARK: - QuestViewOutput
extension LiveQuestPresenter: QuestViewOutput {
    
    func viewDidLoad() {
        let handler = ARSceneViewModel(with: view.sceneView)
        handler.delegate = self
        sceneHandler = handler
        
        trackingService.delegate = self
        interactor.startLocationUpdates()
    }
    
    func viewDidAppear() {
        sceneHandler.launchSession()
    }
    
    func viewDidDisappear() {
        sceneHandler.pauseSession()
    }
}

// MARK: - QuestInteractorOutput
extension LiveQuestPresenter: QuestInteractorOutput {
    
    func didChangeLocationAuthorizationStatus(_ status: CLAuthorizationStatus) {
        print("Authorization status: \(status)")
    }
    
    func didUpdateLocation(_ newLocation: CLLocation, previousLocation: CLLocation?) {
        guard let cameraTransform = sceneHandler.currentCameraTransform() else {
            return
        }
        trackingService.handleLocationUpdate(newLocation: newLocation, currentCameraTransform: cameraTransform)
    }
    
    func didUpdateHeading(_ newHeading: CLHeading) {
    }
    
    func didReceiveLocationFailure(_ error: Error) {
        view.showMessage(error.localizedDescription)
    }
}

// MARK: - ARSceneViewModelDelegate
extension LiveQuestPresenter: ARSceneViewModelDelegate {
    
    func sceneViewModel(_ sceneModel: ARSceneViewModel, didUpdateState state: ARSceneViewState) {
        switch state {
        case .normal, .normalEmptyAnchors:
//            displayNodesIfNeeded()
            break
        default:
//            removeAndCacheNodesIfNeeded()
            break
        }
    }
}

// MARK: - ARTrackingServiceDelegate
extension LiveQuestPresenter: ARTrackingServiceDelegate {
    
    func didUpdateTrackedPosition(with trackingInfo: TrackingInfo) {
        let accuracy = trackingInfo.accuracy()
        view.showMessage("Accuracy: \u{0394} \(accuracy) m.")
    
        if accuracy <= 1 && accuracy >= 0.0001 {
            updateDestinationNodePosition(for: self.destinationCoordinate)
        }
    }
    
    func didStartPositionTracking() {
    }
    
    func handleARSessionReset() {
//        removeAndCacheNodesIfNeeded()
        sceneHandler.reloadSession()
    }
}

extension LiveQuestPresenter {
    
    private func updateDestinationNodePosition(for location: Coordinate) {
        guard let camera = sceneHandler.currentCameraTransform(),
            let currentLocation = trackingService.lastRecognizedLocation else {
                return
        }
        let identifier = location.identifier
        
        var existingNodes: [DestinationNode] = view.sceneView.scene.rootNode.childNodes {
            $0.identifier == identifier
        }
        if existingNodes.isEmpty {
            let destinationNode = DestinationNode(coordinate: location)
            view.sceneView.scene.rootNode.addChildNode(destinationNode)
            existingNodes.append(destinationNode)
        }
        
        for node in existingNodes {
            node.update(with: camera,
                        currentCoordinates: currentLocation.coordinate,
                        thresholdDistance: SceneUtils.sceneRadius)
        }
        
        let estimatedFloorHeight = sceneHandler.estimatedHeight()
        SCNTransaction.animate(withDuration: 0.25, animations: {
            for node in existingNodes {
                let distance = currentLocation.coordinate.distance(to: location)
                let sceneDistance = distance > SceneUtils.sceneRadius ? SceneUtils.sceneRadius : distance
                
                node.applyScale(self.scaleForDistance(sceneDistance))
                node.applyHeight(self.heightForDistance(distance, floorHeight: estimatedFloorHeight))
            }
        })
    }
    
    private func removeDestinationNode(for location: Coordinate) {
        let identifier = location.identifier
        let nodes: [DestinationNode] = view.sceneView.scene.rootNode.childNodes {
            $0.identifier == identifier
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

extension Coordinate {
    static var debugCoordinate: Coordinate {
        return Coordinate(latitude: 50.005938, longitude: 36.230718)
    }
}
