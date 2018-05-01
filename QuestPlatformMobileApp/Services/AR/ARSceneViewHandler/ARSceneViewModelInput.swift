//
//  ARSceneViewModelInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

public protocol ARSceneViewModelInput {
    var state: ARSceneViewState { get }
    
    var cameraTransform: CameraTransform? { get }
    
    func launchSession()
    func pauseSession()
    func reloadSession()
    
    func estimatedHeight() -> Float
    
    func addNode(_ node: SCNNode)
    func addNodes(_ nodes: [SCNNode])
    func removeAllNodes() -> [SCNNode]
}
