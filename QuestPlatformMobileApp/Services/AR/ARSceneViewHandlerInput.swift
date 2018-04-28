//
//  ARSceneViewHandlerInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

public protocol ARSceneViewHandlerInput {
    var state: ARSceneViewState { get }
    
    func launchSession()
    func pauseSession()
    func reloadSession()
    
    func currentCameraTransform() -> matrix_float4x4?
    func estimatedHeight() -> Float
    
    func addNode(_ node: SCNNode)
    func addNodes(_ nodes: [SCNNode])
    func removeAllNodes() -> [SCNNode]
}
