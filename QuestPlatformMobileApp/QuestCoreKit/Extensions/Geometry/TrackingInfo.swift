//
//  TrackingInfo.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

struct TrackingInfo {
    private static let validDistanceDelta: Double = 5
    
    let location: DistanceInfo<CLLocation>
    let camera: DistanceInfo<CameraTransform>
    
    func accuracy() -> Double {
        return abs(location.distance() - camera.distance())
    }
    
    var isValid: Bool {
        return accuracy() <= TrackingInfo.validDistanceDelta
    }
}
