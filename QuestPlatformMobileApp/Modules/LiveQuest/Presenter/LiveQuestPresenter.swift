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
    
    deinit {
        deinited(self)
    }
    
    private var locations: [Container<Coordinate>] = [
        Container(element: Coordinate.debugCoordinate)
    ]
    
    var destination: Coordinate?
    
    private var sceneHandler: ARSceneViewModelInput!
    
    private let trackingService: ARTrackingService = {
        let service = ARTrackingService()
        return service
    }()
}

// MARK: - QuestViewOutput
extension LiveQuestPresenter: QuestViewOutput {
    
    func viewDidLoad() {
        let handler = ARSceneViewModel(with: view.sceneView)
        handler.delegate = self
        sceneHandler = handler
        
        trackingService.delegate = self
        updateNodes(for: self.locations)
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
            displayNodesIfNeeded()
        default:
            removeAndCacheNodesIfNeeded()
        }
    }
}

// MARK: - ARTrackingServiceDelegate
extension LiveQuestPresenter: ARTrackingServiceDelegate {
    
    func didUpdateTrackedPosition(with trackingInfo: TrackingInfo) {
        let accuracy = trackingInfo.accuracy()
        view.showMessage("Accuracy: \u{0394} \(accuracy) m.")
        
        updatePlacemarkNodesContent(self.locations)
        if accuracy <= 1 && accuracy >= 0.0001 {
            updatePlacemarkNodesPosition(self.locations)
        }
    }
    
    func didStartPositionTracking() {
    }
    
    func handleARSessionReset() {
        removeAndCacheNodesIfNeeded()
        sceneHandler.reloadSession()
    }
}

// MARK: - Nodes
extension LiveQuestPresenter {
    
    private func displayNodesIfNeeded() {
//        let nodesToDisplay = trackingService.restoreNodes()
//        if nodesToDisplay.isEmpty { return }
//        sceneHandler.addNodes(nodesToDisplay)
    }
    
    private func removeAndCacheNodesIfNeeded() {
//        let nodesToCache = sceneHandler.removeAllNodes()
//        if nodesToCache.isEmpty { return }
//        interactor.cacheNodes(nodesToCache)
    }
    
    func updateNodes(for placeMarks: [Container<Coordinate>]) {
        let existingNodes: [PlaceNode] = view.sceneView.scene.rootNode.childNodes()
        var nodesTable: [String: PlaceNode] = [:]
        existingNodes.forEach { nodesTable[$0.element.id] = $0 }
        
        let existingPlacemarks = existingNodes.map { $0.element }
        
        let existingIds = Set(nodesTable.keys)
        let currentIds = Set(placeMarks.map { $0.id })
        
        let placemarksToAdd = placeMarks.filter { !existingIds.contains($0.id) }
        let placemarksToUpdate = placeMarks.filter { existingIds.contains($0.id) }
        let placemarksToRemove = existingPlacemarks.filter { !currentIds.contains($0.id) }
        
        addPlacemarkNodes(placemarksToAdd)
        updatePlacemarkNodesPosition(placemarksToUpdate)
        updatePlacemarkNodesContent(placemarksToAdd + placemarksToUpdate)
        removePlacemarkNodes(placemarksToRemove)
    }
    
    private func addPlacemarkNodes(_ placemarks: [Container<Coordinate>]) {
        let nodes = placemarks.map { PlaceNode(element: $0) }
        
        nodes.forEach { view.sceneView.scene.rootNode.addChildNode($0) }
        updatePlacemarkNodesPosition(placemarks)
    }
    
    private func updatePlacemarkNodesPosition(_ placemarks: [Container<Coordinate>]) {
        guard let currentLocation = trackingService.lastRecognizedLocation else { return }
        guard let cameraTransform = sceneHandler.currentCameraTransform() else { return }
        
        let idsToUpdate = Set(placemarks.map { $0.id })
        let nodesToUpdate: [PlaceNode] = view.sceneView.scene.rootNode.childNodes { idsToUpdate.contains($0.element.id) }
        
        nodesToUpdate.forEach { $0.updateWith(currentCameraTransform: cameraTransform,
                                              currentCoordinates: currentLocation.coordinate,
                                              thresholdDistance: SceneUtils.sceneRadius) }
        
        let estimatedFloorHeight = sceneHandler.estimatedHeight()
        SCNTransaction.animate(withDuration: 0.25, animations: { [weak self] in
            guard let wSelf = self else { return }
            
            nodesToUpdate.forEach { (node) in
                let distance = currentLocation.coordinate.distance(to: node.element.element)
                let sceneDistance = distance > SceneUtils.sceneRadius ? SceneUtils.sceneRadius : distance
                
                node.applyScale(wSelf.scaleForDistance(sceneDistance))
                node.applyHeight(wSelf.heightForDistance(distance, floorHeight: estimatedFloorHeight))
            }
        })
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
    
    private func updatePlacemarkNodesContent(_ placemarks: [Container<Coordinate>]) {
        guard let currentLocation = trackingService.lastRecognizedLocation else { return }
        let idsToUpdate = Set(placemarks.map { $0.id })
        let nodesToUpdate: [PlaceNode] = view.sceneView.scene.rootNode.childNodes { idsToUpdate.contains($0.element.id) }
        
        nodesToUpdate.forEach { (node) in
            trackingService.requestPlaces(for: node.element.element) { [weak self] (placemark) in
                guard let wSelf = self else { return }
                
                guard let placemark = placemark else { return }
                let distance = currentLocation.coordinate.distance(to: node.element.element)
                
                let description = wSelf.formAttributedDescription(for: placemark, distance: distance)
                DispatchQueue.main.async {
                    node.updateContent(description)
                }
            }
        }
    }
    
    private func formAttributedDescription(for placemark: CLPlacemark, distance: Double) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: "")
        let placemarkInfo = NSAttributedString(string: placemark.mainInfo + "\n" + placemark.subInfo + "\n",
                                               attributes: [.font: UIFont(name: "HelveticaNeue", size: BannerNode.defaultFontSize)!,
                                                            .foregroundColor: UIColor.white])
        let truncatedDistance = Double(Int(distance * 100)) / 100
        let distanceInfo = NSAttributedString(string: "\(truncatedDistance) meters",
            attributes: [.font: UIFont(name: "HelveticaNeue", size: BannerNode.defaultFontSize)!,
                         .foregroundColor: UIColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 1)])
        fullString.append(placemarkInfo)
        fullString.append(distanceInfo)
        
        return fullString
    }
    
    private func removePlacemarkNodes(_ placemarks: [Container<Coordinate>]) {
        let idsToRemove = Set(placemarks.map { $0.id })
        let nodesToRemove: [PlaceNode] = view.sceneView.scene.rootNode.childNodes { idsToRemove.contains($0.element.id) }
        nodesToRemove.forEach { $0.removeFromParentNode() }
    }
}

extension Coordinate {
    static var debugCoordinate: Coordinate {
        return Coordinate(latitude: 50.005938, longitude: 36.230718)
    }
}

extension CLPlacemark {
    var mainInfo: String {
        return name ?? ""
    }
    
    var subInfo: String {
        var info = ""
        
        if let locality = locality { info += locality }
        if let subLocality = subLocality { info += ", \(subLocality)" }
        if let administrativeArea = administrativeArea { info += ", \(administrativeArea)" }
        if let country = country { info += ", \(country)" }
        
        return info
    }
}

