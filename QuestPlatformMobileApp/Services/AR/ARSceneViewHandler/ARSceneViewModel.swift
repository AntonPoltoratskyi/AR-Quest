//
//  ARSceneViewModel.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import ARKit
import SceneKit

public final class ARSceneViewModel: NSObject {
    
    public weak var delegate: ARSceneViewModelDelegate?
    public weak var scene: ARSCNView!
    
    public var state: ARSceneViewState = .limitedInitializing {
        didSet {
            delegate?.sceneViewModel(self, didUpdateState: state)
        }
    }
    
    private var session: ARSession {
        return scene.session
    }
    
    private let updateQueue = DispatchQueue.queue(for: ARSceneViewModel.self)
    
    private var displayFloor = true
    private var recognizedHeights: [ARAnchor: Float] = [:]
    
    // MARK: - Init
    
    public init(with scene: ARSCNView) {
        self.scene = scene
        
        super.init()
        if ARWorldTrackingConfiguration.isSupported {
            setup()
        }
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        UIApplication.shared.isIdleTimerDisabled = true
        
        setupScene()
        
        if let camera = scene.pointOfView?.camera {
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
        }
    }
    
    private func setupScene() {
        scene.delegate = self
        session.delegate = self
        
        scene.scene = SCNScene()
        
        scene.automaticallyUpdatesLighting = true
        scene.autoenablesDefaultLighting = true
        
        scene.showsStatistics = false
        
        scene.debugOptions = [
            ARSCNDebugOptions.showWorldOrigin
        ]
    }
    
    private func clearStoredDate() {
        recognizedHeights.removeAll()
    }
}

// MARK: - Public Input
extension ARSceneViewModel: ARSceneViewModelInput {
    
    public var cameraTransform: CameraTransform? {
        return session.currentFrame?.camera.transform
    }
    
    public func estimatedHeight() -> Float {
        return recognizedHeights.values.min() ?? -1.5
    }
    
    public func launchSession() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        
        clearStoredDate()
        let configuration = state.configuration
        session.run(configuration)
    }
    
    public func pauseSession() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        session.pause()
    }
    
    public func reloadSession() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        let options: ARSession.RunOptions =  [.resetTracking, .removeExistingAnchors]
        let configuration = state.configuration
        session.run(configuration, options: options)
    }
    
    public func addNode(_ node: SCNNode) {
        scene?.scene.rootNode.addChildNode(node)
    }
    
    public func addNodes(_ nodes: [SCNNode]) {
        nodes.forEach { addNode($0) }
    }
    
    public func removeAllNodes() -> [SCNNode] {
        let nodesToRemove = scene?.scene.rootNode.childNodes ?? []
        nodesToRemove.forEach { $0.removeFromParentNode() }
        return nodesToRemove
    }
}

// MARK: - ARSCNViewDelegate
extension ARSceneViewModel: ARSCNViewDelegate {
    
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        recognizedHeights[anchor] = node.position.y
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        recognizedHeights[anchor] = node.position.y
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        recognizedHeights[anchor] = nil
    }
}

// MARK: - ARSessionDelegate
extension ARSceneViewModel: ARSessionDelegate {
    
    public func updateState(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        switch trackingState {
        case .normal where frame.anchors.isEmpty:
            state = .normalEmptyAnchors
        case .normal:
            state = .normal
        case .notAvailable:
            state = .notAvailable
        case .limited(.excessiveMotion):
            state = .limitedExcessiveMotion
        case .limited(.insufficientFeatures):
            state = .limitedInsufficientFeatures
        case .limited(.initializing):
            state = .limitedInitializing
        case .limited(.relocalizing):
            state = .relocalizing
        }
    }
    
    public func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let frame = session.currentFrame else {
            return
        }
        updateState(for: frame, trackingState: frame.camera.trackingState)
    }
    
    public func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        guard let frame = session.currentFrame else {
            return
        }
        updateState(for: frame, trackingState: frame.camera.trackingState)
    }
    
    public func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        guard let frame = session.currentFrame else {
            return
        }
        updateState(for: frame, trackingState: camera.trackingState)
    }
}

// MARK: - ARSessionObserver
extension ARSceneViewModel {
    
    public func sessionWasInterrupted(_ session: ARSession) {
        state = .interrupted
    }
    
    public func sessionInterruptionEnded(_ session: ARSession) {
        state = .interruptionEnded
        reloadSession()
    }
    
    public func session(_ session: ARSession, didFailWithError error: Error) {
        state = .failed(error)
        reloadSession()
    }
}
