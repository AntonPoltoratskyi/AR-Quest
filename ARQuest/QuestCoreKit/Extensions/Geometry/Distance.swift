//
//  Distance.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import CoreLocation

struct DistanceInfo<T> {
    var old: T
    var new: T
}

extension DistanceInfo where T: DistanceRepresentable, T.Target == T {
    func distance() -> Distance {
        return old.distance(to: new)
    }
}
