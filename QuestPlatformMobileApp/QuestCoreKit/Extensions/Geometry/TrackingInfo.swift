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
    let location: DistanceInfo<CLLocation>
    let camera: DistanceInfo<matrix_float4x4>
    
    func accuracy() -> Double {
        return abs(location.distance() - camera.distance())
    }
}
