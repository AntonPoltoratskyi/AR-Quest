//
//  ARTrackingService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

final class ARTrackingService: ARTrackingServiceInput {
    
    weak var delegate: ARTrackingServiceDelegate?
    
    public var lastRecognizedLocation: CLLocation?
    public var lastRecognizedCameraTransform: matrix_float4x4?
    
    private var errorFactorCount = 0
    private let errorThreshold = 10
    private let acceptableDistanceDiff: Double = 5 // in meters
    
    private let navigationManager = NavigationService()
    
    public func requestPlaces(for coordinate: Coordinate, callback: @escaping (CLPlacemark?) -> Void) {
        navigationManager.requestPlaces(for: coordinate) { (placemark, error) in
            if let error = error {
                debugPrint(error)
            }
            callback(placemark)
        }
    }
    
    public func handleLocationUpdate(newLocation: CLLocation, currentCameraTransform: matrix_float4x4) {
        if let lastLocation = lastRecognizedLocation, let lastTransform = lastRecognizedCameraTransform {
            let locationDifference = DistanceInfo(old: lastLocation, new: newLocation)
            let cameraDifference = DistanceInfo(old: currentCameraTransform, new: lastTransform)
            
            let trackingInfo = TrackingInfo(location: locationDifference, camera: cameraDifference)
            
            // Check if changed is valid
            if trackingInfo.accuracy() <= acceptableDistanceDiff {
                errorFactorCount = 0
                delegate?.didUpdateTrackedPosition(with: trackingInfo)
            } else {
                errorFactorCount += 1
                if errorFactorCount >= errorThreshold {
                    errorFactorCount = 0
                    delegate?.handleARSessionReset()
                }
            }
            
            lastRecognizedLocation = newLocation
            lastRecognizedCameraTransform = currentCameraTransform
        } else {
            lastRecognizedLocation = newLocation
            lastRecognizedCameraTransform = currentCameraTransform
            delegate?.didStartPositionTracking()
        }
    }
}
