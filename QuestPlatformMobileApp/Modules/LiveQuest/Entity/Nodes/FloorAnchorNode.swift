//
//  FloorAnchorNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

final class FloorAnchorNode: SCNNode {
    var anchor: ARPlaneAnchor
    
    var surfaceGeometry: SCNPlane? {
        return geometry as? SCNPlane
    }
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        
        geometry = SCNPlane(width: 0, height: 0)
        eulerAngles = SCNVector3(-.pi / 2, 0.0, 0.0)
        
        updatePostition(anchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePostition(_ anchor: ARPlaneAnchor) {
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        surfaceGeometry?.width = CGFloat(anchor.extent.x)
        surfaceGeometry?.height = CGFloat(anchor.extent.z)
    }
}

