//
//  SceneKitExtensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 18.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

extension SCNMatrix4 {
    var orientation: SCNVector3 {
        return SCNVector3(-m31, -m32, -m33)
    }
    var location: SCNVector3 {
        return SCNVector3(m41, m42, m43)
    }
}
