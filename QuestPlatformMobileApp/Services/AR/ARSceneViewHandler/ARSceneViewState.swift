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
            return "AR Session prepared."
        case .normalEmptyAnchors:
            return "Move the device around to detect horizontal surfaces."
        case .notAvailable:
            return "Tracking unavailable."
        case .limitedExcessiveMotion:
            return "Tracking limited - Move the device more slowly."
        case .limitedInsufficientFeatures:
            return "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
        case .limitedInitializing:
            return "Initializing AR session."
        case .relocalizing:
            return "Relocalizing AR session."
        case .interrupted:
            return "Session was interrupted"
        case .interruptionEnded:
            return "Session interruption ended"
        case .failed(let error):
            return "Session failed: \(error.localizedDescription)"
        }
    }
}
