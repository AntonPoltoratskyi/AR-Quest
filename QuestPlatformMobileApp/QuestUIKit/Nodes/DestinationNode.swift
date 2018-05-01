//
//  DestinationNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

final class DestinationNode: ARQuestNode {
    
    let coordinate: Coordinate
    
    private var cylinder: DestinationCylinderNode!
    
    
    // MARK: - Init
    
    init(coordinate: Coordinate, identifier: String) {
        self.coordinate = coordinate
        super.init()
        self.identifier = identifier
        
        cylinder = DestinationCylinderNode()
        addChildNode(cylinder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        let box = SCNSphere(radius: 4)
        
        box.firstMaterial?.diffuse.contents = UIColor.red
        box.firstMaterial?.isDoubleSided = true
        
        geometry = box
        
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

final class DestinationCylinderNode: ARQuestNode {
    
    override func setup() {
        super.setup()
        
        let box = SCNTube(innerRadius: 6.5, outerRadius: 7, height: 0.1)
        
        box.firstMaterial?.diffuse.contents = UIColor.white
        box.firstMaterial?.isDoubleSided = true
        
        geometry = box
        eulerAngles = SCNVector3(Float(90.0.degreesToRadians), 0, 0)
    }
}
