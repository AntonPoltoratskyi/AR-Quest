//
//  SCNVector3.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 18.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, rhs.z + rhs.z)
}
