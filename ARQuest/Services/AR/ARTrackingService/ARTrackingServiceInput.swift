//
//  ARTrackingServiceInput.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import SceneKit

protocol ARTrackingServiceInput: class {
    
    var delegate: ARTrackingServiceDelegate? { get set }
    
    var lastRecognizedLocation: CLLocation? { get set }
    var lastRecognizedCameraTransform: CameraTransform? { get set }
    
    func update(location: CLLocation, camera: CameraTransform)
}
