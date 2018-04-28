//
//  Difference.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import CoreLocation

struct Difference<T> {
    var oldValue: T
    var newValue: T
}

extension Difference where T: CLLocation {
    func bias() -> Double {
        return oldValue.distance(from: newValue)
    }
}

extension Difference where T == matrix_float4x4 {
    func bias() -> Double {
        return Double(oldValue.translationVector.distance(to: newValue.translationVector))
    }
}
