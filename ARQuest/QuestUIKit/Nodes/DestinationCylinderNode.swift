//
//  DestinationCylinderNode.swift
//  ARQuest
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

final class TorusNode: ARQuestNode {
    
    override func setup() {
        super.setup()
        
        let box = SCNTorus(ringRadius: 3, pipeRadius: 1)
        
        box.firstMaterial?.diffuse.contents = UIColor(r: 232, g: 26, b: 11)
        box.firstMaterial?.isDoubleSided = true
        
        geometry = box
    }
}

final class ConusNode: ARQuestNode {
    
    override func setup() {
        super.setup()
        
        let box = SCNCone(topRadius: 0, bottomRadius: 4, height: 8)
        
        box.firstMaterial?.diffuse.contents = UIColor(r: 232, g: 26, b: 11)
        box.firstMaterial?.isDoubleSided = true
        
        geometry = box
        
        eulerAngles = SCNVector3(Float(180.0.degreesToRadians), 0, 0)
    }
}
