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
    
    func applyTransformBetween(currentCoordinate: Coordinate,
                               destinationCoordinate: Coordinate) -> SCNMatrix4 {
        var result = self
        
        let distance = Float(currentCoordinate.distance(to: destinationCoordinate))
        let translation = SCNMatrix4MakeTranslation(0, 0, -distance)
        result = SCNMatrix4Mult(result, translation)
        
        let angle = Float(currentCoordinate.angle(to: destinationCoordinate))
        let rotationMatrix = SCNMatrix4MakeRotation(angle, 0, 1, 0)
        result = SCNMatrix4Mult(result, SCNMatrix4Invert(rotationMatrix))
        
        return result
    }
}

extension SCNMatrix4 {
    
    func transformed(from current: Coordinate, destination: Coordinate, thresholdDistance: Double) -> SCNMatrix4 {
        let distance = min(current.distance(to: destination), thresholdDistance)
        let bearing = current.angle(to: destination)
        
        var transform = self
        
        let translation = SCNMatrix4MakeTranslation(0, 0, -Float(distance))
        transform = SCNMatrix4Mult(transform, translation)
        
        let rotate = SCNMatrix4MakeRotation(Float(bearing), 0, 1, 0)
        transform = SCNMatrix4Mult(transform, SCNMatrix4Invert(rotate))
        
        return transform
    }
}
