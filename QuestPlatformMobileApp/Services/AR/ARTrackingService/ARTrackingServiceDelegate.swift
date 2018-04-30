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
    func didStartPositionTracking()
    func didUpdateTrackedPosition(with trackingInfo: TrackingInfo)
    func handleARSessionReset()
}
