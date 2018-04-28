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
    
    public func requestPlaces(for coordinate: CLLocationCoordinate2D, callback: @escaping (CLPlacemark?) -> Void) {
        navigationManager.requestPlaces(for: coordinate) { (placemark, error) in
            if let error = error {
                debugPrint(error)
            }
            callback(placemark)
        }
    }
    
    public func handleLocationUpdate(newLocation: CLLocation, currentCameraTransform: matrix_float4x4) {
        if let lastLocation = lastRecognizedLocation, let lastTransform = lastRecognizedCameraTransform {
            let locationDifference = Difference(oldValue: lastLocation, newValue: newLocation)
            let cameraDifference = Difference(oldValue: currentCameraTransform, newValue: lastTransform)
            
            if isChangesAcceptable(locationDiff: locationDifference, cameraDiff: cameraDifference) {
                errorFactorCount = 0
                delegate?.handlePositionUpdate(locationDiff: locationDifference, cameraDiff: cameraDifference)
            } else {
                errorFactorCount += 1
                if errorFactorCount >= errorThreshold {
                    errorFactorCount = 0
                    delegate?.handleReset()
                }
            }
            
            lastRecognizedLocation = newLocation
            lastRecognizedCameraTransform = currentCameraTransform
        } else {
            lastRecognizedLocation = newLocation
            lastRecognizedCameraTransform = currentCameraTransform
            delegate?.handleInitialPositioning()
        }
    }
    
    private func isChangesAcceptable(locationDiff: Difference<CLLocation>, cameraDiff: Difference<matrix_float4x4>) -> Bool {
        let locationTranslation = locationDiff.bias()
        let cameraTranslation = cameraDiff.bias()
        
        let actualDiff = abs(locationTranslation - cameraTranslation)
        
        return actualDiff <= acceptableDistanceDiff
    }
}
