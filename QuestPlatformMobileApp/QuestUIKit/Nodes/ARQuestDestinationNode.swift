//
//  ARQuestDestinationNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 17.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

class ARQuestDestinationNode: ARQuestNode {
    
    let coordinate: Coordinate

    
    // MARK: - Init
    
    init(coordinate: Coordinate, identifier: String) {
        self.coordinate = coordinate
        super.init()
        self.identifier = identifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        let coneTop = ConusNode()
        let torus = TorusNode()
        
        coneTop.position = SCNVector3(0, 5, 0)
        torus.position = SCNVector3(0, 0, 0)
        
        addChildNode(coneTop)
        addChildNode(torus)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .Y
        constraints = [billboardConstraint]
    }
    
    func update(with cameraTransform: CameraTransform, currentCoordinates: Coordinate, thresholdDistance: Double) {
        var maxtix = matrix_identity_float4x4
        maxtix.columns.3.x = cameraTransform.columns.3.x
        maxtix.columns.3.y = simdTransform.columns.3.y
        maxtix.columns.3.z = cameraTransform.columns.3.z
        
        transform = maxtix.scnMatrix.transformed(
            from: currentCoordinates,
            destination: self.coordinate,
            thresholdDistance: thresholdDistance
        )
    }
    
    func applyScale(_ scale: Float) {
        let scaleValue = (1 / Float(ARConstants.sceneRadius)) * scale
        self.scale = SCNVector3(scaleValue, scaleValue, scaleValue)
    }
    
    func applyHeight(_ newHeight: Float) {
        simdTransform.columns.3.y = newHeight
    }
}
