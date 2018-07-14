//
//  ARConstants.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum ARConstants {
    
    /// Max visible radius (in meters).
    static let sceneRadius = 250.0
    
    /// Restart ARSession when this value reached.
    static let maxErrorLimit = 10
    
    /// Distance to quest task's destination node (in meters).
    static let destinationDistance: Double = 10
}
