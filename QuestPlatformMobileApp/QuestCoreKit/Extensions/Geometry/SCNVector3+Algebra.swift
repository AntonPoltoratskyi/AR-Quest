//
//  SCNVector3+Algebra.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import CoreLocation

extension SCNVector3 {
    static var zero: SCNVector3 {
        return SCNVector3Zero
    }
    
    var length: Float {
        return sqrtf(x * x + y * y + z * z)
    }
    
    var normalized: SCNVector3 {
        return self / length
    }
    
    func distance(to vector: SCNVector3) -> Float {
        return (self - vector).length
    }
    
    func transform(initialCoordinates: Coordinate, destination: Coordinate) -> matrix_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.columns.3.x = x
        matrix.columns.3.y = y
        matrix.columns.3.z = z
        
        return matrix.transformed(from: initialCoordinates, destination: destination)
    }
}
