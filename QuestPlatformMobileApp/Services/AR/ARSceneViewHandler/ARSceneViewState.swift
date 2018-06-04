//
//  ARSceneViewState.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import ARKit

public enum ARSceneViewState {
    case normal
    case normalEmptyAnchors
    case notAvailable
    case limitedExcessiveMotion
    case limitedInsufficientFeatures
    case limitedInitializing
    case relocalizing
    
    case interrupted
    case interruptionEnded
    case failed(Error)
    
    public var configuration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        configuration.worldAlignment = .gravityAndHeading
        configuration.planeDetection = .horizontal
        
        return configuration
    }
    
    public var hint: String {
        switch self {
        case .normal:
            return "Go!"
        case .normalEmptyAnchors:
            return "Move the device around"
        case .notAvailable:
            return "Tracking unavailable"
        case .limitedExcessiveMotion:
            return "Tracking limited - Move the device more slowly"
        case .limitedInsufficientFeatures:
            return "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions"
        case .limitedInitializing:
            return "Initializing"
        case .relocalizing:
            return "Relocalizing"
        case .interrupted:
            return "Interruption occurred"
        case .interruptionEnded:
            return "Interruption ended"
        case .failed(let error):
            return "Session failed: \(error.localizedDescription)"
        }
    }
}
