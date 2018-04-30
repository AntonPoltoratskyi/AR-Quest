//
//  SCNNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 18.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    func centerPivot() {
        let min = boundingBox.min
        let max = boundingBox.max
        pivot = SCNMatrix4MakeTranslation(
            min.x + (max.x - min.x)/2,
            min.y + (max.y - min.y)/2,
            min.z + (max.z - min.z)/2
        )
    }
    
    func setColor(_ color: UIColor) {
        geometry?.firstMaterial?.diffuse.contents = color
    }
    
    func childNodes<T>(matching predicate: ((T) -> Bool)? = nil) -> [T] {
        var childs = childNodes.compactMap { $0 as? T }
        if let predicate = predicate {
            childs = childs.filter(predicate)
        }
        return childs
    }
}
