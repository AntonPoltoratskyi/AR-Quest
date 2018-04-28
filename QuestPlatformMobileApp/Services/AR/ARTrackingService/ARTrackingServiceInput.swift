//
//  ARTrackingServiceInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

protocol ARTrackingServiceInput: class {
    
    var lastRecognizedLocation: CLLocation? { get set }
    var lastRecognizedCameraTransform: matrix_float4x4? { get set }
    
    func requestPlaces(for coordinate: CLLocationCoordinate2D, callback: @escaping (CLPlacemark?) -> Void)
    func handleLocationUpdate(newLocation: CLLocation, currentCameraTransform: matrix_float4x4)
}
