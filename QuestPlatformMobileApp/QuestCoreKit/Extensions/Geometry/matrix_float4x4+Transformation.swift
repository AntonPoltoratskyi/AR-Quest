//
//  matrix_float4x4+Transformation.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import CoreLocation

extension matrix_float4x4 {
    
    var scnMatrix: SCNMatrix4 {
        return SCNMatrix4(float4x4(columns: columns))
    }
    
    var translationVector: SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
}

extension matrix_float4x4 {
    
    func transformed(from current: Coordinate, destination: Coordinate) -> matrix_float4x4 {
        let distance = current.distance(to: destination)
        let bearingAngle = current.bearingAngle(to: destination)
        
        let position = vector_float4(0, 0, -Float(distance), 1)
        let translatedMatrix = translated(to: position)
        let rotatedMatrix = translatedMatrix.rotated(byY: Float(bearingAngle))
        
        return rotatedMatrix
    }
    
    // column 0  column 1  column 2  column 3
    // --------------------------------------
    //    cosθ      0       sinθ      0    
    //     0        1         0       0    
    //   −sinθ      0       cosθ      0    
    //     0        0         0       1    
    // --------------------------------------
    private func rotated(byY radians: Float) -> matrix_float4x4 {
        var rotation = matrix_identity_float4x4
        
        rotation.columns.0.x = cos(radians)
        rotation.columns.0.z = -sin(radians)
        
        rotation.columns.2.x = sin(radians)
        rotation.columns.2.z = cos(radians)
        
        return simd_mul(rotation.inverse, self)
    }
    
    private func translated(to vector: vector_float4) -> matrix_float4x4 {
        var translation = matrix_identity_float4x4
        translation.columns.3 = vector
        return simd_mul(self, translation)
    }
}
