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
    
    private var isARSessionReady = false
    
    private var locations: [Container<CLLocationCoordinate2D>] = [
        Container(element: CLLocationCoordinate2D.debugCoordinate)
    ]
    
    var destination: CLLocationCoordinate2D?
    
    private var sceneHandler: ARSceneViewHandlerInput!
    
    private let trackingService: ARTrackingService = {
        let service = ARTrackingService()
        return service
    }()
}

// MARK: - QuestViewOutput
extension LiveQuestPresenter: QuestViewOutput {
    
    func viewDidLoad() {
        let handler = ARSceneViewHandler(with: view.sceneView)
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
    
    func handleUpdatedLocation(_ newLocation: CLLocation, previousLocation: CLLocation?) {
        guard let cameraTransform = sceneHandler.currentCameraTransform() else {
            return
        }
        trackingService.handleLocationUpdate(newLocation: newLocation, currentCameraTransform: cameraTransform)
    }
    
    func handleUpdatedHeading(_ newHeading: CLHeading) {
        
    }
    
    func handleLocationUpdateFailure(_ error: Error) {
        view.showMessage(error.localizedDescription)
    }
}


extension LiveQuestPresenter {
    
    func handleLocationUpdate(newLocation: CLLocation, previous: CLLocation?) {
        
    }
}

// MARK: - ARSceneViewHandlerDelegate
extension LiveQuestPresenter: ARSceneViewHandlerDelegate {
    
    func sceneViewHandler(_ handler: ARSceneViewHandler, didUpdateState state: ARSceneViewState) {
        switch state {
        case .normal, .normalEmptyAnchors:
            isARSessionReady = true
            displayNodesIfNeeded()
        default:
            isARSessionReady = false
            removeAndCacheNodesIfNeeded()
        }
    }
}

// MARK: - ARTrackingServiceDelegate
extension LiveQuestPresenter: ARTrackingServiceDelegate {
    
    func handleInitialPositioning() {
    }
    
    func handlePositionUpdate(locationDiff: Difference<CLLocation>, cameraDiff: Difference<matrix_float4x4>) {
        let locationTranslation = locationDiff.bias()
        let cameraTranslation = cameraDiff.bias()
        
        let accuracy = Double(Int(abs(locationTranslation - cameraTranslation) * 1000)) / 1000
        view.showMessage("Accuracy: ±\(accuracy)(m)")
        
        updatePlacemarkNodesContent(self.locations)
        
        if accuracy <= 1 && accuracy >= 0.0001 {
            updatePlacemarkNodesPosition(self.locations)
        }
    }
    
    func handleReset() {
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
    
    func updateNodes(for placeMarks: [Container<CLLocationCoordinate2D>]) {
        let existingNodes: [PlacemarkNode] = view.sceneView.scene.rootNode.childs()
        var nodesTable: [String: PlacemarkNode] = [:]
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
    
    private func addPlacemarkNodes(_ placemarks: [Container<CLLocationCoordinate2D>]) {
        let nodes = placemarks.map { PlacemarkNode(element: $0) }
        
        nodes.forEach { view.sceneView.scene.rootNode.addChildNode($0) }
        updatePlacemarkNodesPosition(placemarks)
    }
    
    private func updatePlacemarkNodesPosition(_ placemarks: [Container<CLLocationCoordinate2D>]) {
        guard let currentLocation = trackingService.lastRecognizedLocation else { return }
        guard let cameraTransform = sceneHandler.currentCameraTransform() else { return }
        
        let idsToUpdate = Set(placemarks.map { $0.id })
        let nodesToUpdate: [PlacemarkNode] = view.sceneView.scene.rootNode.childs { idsToUpdate.contains($0.element.id) }
        
        nodesToUpdate.forEach { $0.updateWith(currentCameraTransform: cameraTransform,
                                              currentCoordinates: currentLocation.coordinate,
                                              thresholdDistance: DeveloperSettings.maxSceneRadius) }
        
        let estimatedFloorHeight = sceneHandler.estimatedHeight()
        SCNTransaction.animate(with: 0.25, { [weak self] in
            guard let wSelf = self else { return }
            
            nodesToUpdate.forEach { (node) in
                let distance = currentLocation.coordinate.distance(to: node.element.element)
                let sceneDistance = distance > DeveloperSettings.maxSceneRadius ? DeveloperSettings.maxSceneRadius : distance
                
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
    
    private func updatePlacemarkNodesContent(_ placemarks: [Container<CLLocationCoordinate2D>]) {
        guard let currentLocation = trackingService.lastRecognizedLocation else { return }
        let idsToUpdate = Set(placemarks.map { $0.id })
        let nodesToUpdate: [PlacemarkNode] = view.sceneView.scene.rootNode.childs { idsToUpdate.contains($0.element.id) }
        
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
    
    private func removePlacemarkNodes(_ placemarks: [Container<CLLocationCoordinate2D>]) {
        let idsToRemove = Set(placemarks.map { $0.id })
        let nodesToRemove: [PlacemarkNode] = view.sceneView.scene.rootNode.childs { idsToRemove.contains($0.element.id) }
        nodesToRemove.forEach { $0.removeFromParentNode() }
    }
}




extension CLLocationCoordinate2D {
    static var debugCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 50.005938, longitude: 36.230718)
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

