//
//  DestinationNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

extension Coordinate {
    var identifier: String {
        return "\(latitude);\(longitude)"
    }
}

final class DestinationNode: ARQuestNode {
    
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
        let box = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
        
        box.firstMaterial?.diffuse.contents = UIColor.red
        box.firstMaterial?.isDoubleSided = true
        
        geometry = box
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .Y
        constraints = [billboardConstraint]
    }
    
    func update(with cameraTransform: matrix_float4x4, currentCoordinates: Coordinate, thresholdDistance: Double) {
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
        let scaleValue = (1 / Float(SceneUtils.sceneRadius)) * scale
        self.scale = SCNVector3(scaleValue, scaleValue, scaleValue)
        // TODO: apply scale to childs
    }
    
    func applyHeight(_ newHeight: Float) {
        simdTransform.columns.3.y = newHeight
    }
}
