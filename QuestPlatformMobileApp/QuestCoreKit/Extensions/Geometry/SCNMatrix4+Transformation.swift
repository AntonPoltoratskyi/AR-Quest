//
//  SCNMatrix4+Transformation.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import CoreLocation

extension SCNMatrix4 {
    
    func transformed(from current: Coordinate, destination: Coordinate, thresholdDistance: Double) -> SCNMatrix4 {
        let distance = min(current.distance(to: destination), thresholdDistance)
        let bearing = current.bearingAngle(to: destination)
        
        var transform = self
        
        let translation = SCNMatrix4MakeTranslation(0, 0, -Float(distance))
        transform = SCNMatrix4Mult(transform, translation)
        
        let rotate = SCNMatrix4MakeRotation(Float(bearing), 0, 1, 0)
        transform = SCNMatrix4Mult(transform, SCNMatrix4Invert(rotate))
        
        return transform
    }
}
