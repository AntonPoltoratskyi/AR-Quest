//
//  ARTrackingService.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

final class ARTrackingService: ARTrackingServiceInput {
    
    weak var delegate: ARTrackingServiceDelegate?
    
    public var lastRecognizedLocation: CLLocation?
    public var lastRecognizedCameraTransform: CameraTransform?
    
    private var errorCounter = 0
    
    public func update(location: CLLocation, camera: CameraTransform) {
        guard let lastLocation = lastRecognizedLocation, let lastTransform = lastRecognizedCameraTransform else {
            lastRecognizedLocation = location
            lastRecognizedCameraTransform = camera
            delegate?.sessionDidStartTracking()
            return
        }

        let locationDelta = DistanceInfo(old: lastLocation, new: location)
        let cameraDelta = DistanceInfo(old: lastTransform, new: camera)
        
        let distanceInfo = TrackingInfo(location: locationDelta, camera: cameraDelta)
        handleTrackingInfo(distanceInfo)
        
        lastRecognizedLocation = location
        lastRecognizedCameraTransform = camera
    }
    
    private func handleTrackingInfo(_ trackingInfo: TrackingInfo) {
        if trackingInfo.isValid {
            handleLocationUpdate(trackingInfo)
        } else {
            handleLocationError()
        }
    }
    
    private func handleLocationUpdate(_ trackingInfo: TrackingInfo) {
        errorCounter = 0
        delegate?.sessionDidUpdate(with: trackingInfo)
    }
    
    private func handleLocationError() {
        errorCounter += 1
        guard errorCounter >= ARConstants.maxErrorLimit else {
            return
        }
        errorCounter = 0
        delegate?.sessionDidBecomeInvalid()
    }
}
