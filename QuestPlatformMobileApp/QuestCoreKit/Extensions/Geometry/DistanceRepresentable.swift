//
//  DistanceRepresentable.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

protocol DistanceRepresentable {
    associatedtype Target
    func distance(to target: Target) -> Distance
}

extension CLLocation: DistanceRepresentable {
    func distance(to target: CLLocation) -> Distance {
        return self.distance(from: target)
    }
}

extension matrix_float4x4: DistanceRepresentable {
    func distance(to target: matrix_float4x4) -> Distance {
        return Distance(translationVector.distance(to: target.translationVector))
    }
}
