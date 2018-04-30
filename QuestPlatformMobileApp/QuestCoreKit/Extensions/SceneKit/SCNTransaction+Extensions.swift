//
//  SCNTransaction+Extensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

extension SCNTransaction {
    
    public enum TimingFunction {
        case linear, easeIn, easeOut, easeInOut, `default`
        
        var value: String {
            switch self {
            case .linear:
                return kCAMediaTimingFunctionLinear
            case .easeIn:
                return kCAMediaTimingFunctionEaseIn
            case .easeOut:
                return kCAMediaTimingFunctionEaseOut
            case .easeInOut:
                return kCAMediaTimingFunctionEaseInEaseOut
            case .default:
                return kCAMediaTimingFunctionDefault
            }
        }
    }
    
    public static func animate(withDuration duration: TimeInterval,
                               timingFunction: TimingFunction = .default,
                               animations: @escaping () -> Void,
                               completion: (() -> Void)? = nil) {
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: timingFunction.value)
        SCNTransaction.animationDuration = duration
        
        animations()
        
        SCNTransaction.completionBlock = completion
        SCNTransaction.commit()
    }
}
