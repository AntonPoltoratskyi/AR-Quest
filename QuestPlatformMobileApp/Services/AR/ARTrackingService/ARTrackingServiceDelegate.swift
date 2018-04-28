//
//  ARTrackingServiceDelegate.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

protocol ARTrackingServiceDelegate: class {
    func handleInitialPositioning()
    func handlePositionUpdate(locationDiff: Difference<CLLocation>, cameraDiff: Difference<matrix_float4x4>)
    func handleReset()
}
