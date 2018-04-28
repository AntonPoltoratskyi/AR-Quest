//
//  SCNVector3+Hashable.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

extension SCNVector3: Hashable {
    public var hashValue: Int {
        return "\(x);\(y);\(z)".hashValue
    }
}
