//
//  DestinationCylinderNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

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
