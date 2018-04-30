//
//  BaseNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit
import MapKit

class BaseNode<Source>: SCNNode {
    var sourceId: String = ""
    var element: Source
    
    init(element: Source) {
        self.element = element
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(currentCameraTransform: matrix_float4x4, currentCoordinates: Coordinate, thresholdDistance: Double) {
        fatalError("Not implemented")
    }
    
    func applyScale(_ scaleFactor: Float) {
        fatalError("Not implemented")
    }
    
    var geometryHeightOffSet: Float {
        return 0
    }
    
    func applyHeight(_ newHeight: Float) {
        simdTransform.columns.3.y = newHeight + geometryHeightOffSet
    }
}
