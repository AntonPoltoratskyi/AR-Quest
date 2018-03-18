//
//  Radians.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 18.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

protocol RadiansConvertible {
    var degreesToRadians: Double { get }
    var radiansToDegrees: Double { get }
}

extension CGFloat: RadiansConvertible {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
    var radiansToDegrees: Double {
        return Double(self) * 180 / .pi
    }
}
extension Double: RadiansConvertible {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
    var radiansToDegrees: Double {
        return Double(self) * 180 / .pi
    }
}
extension Int: RadiansConvertible {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
    var radiansToDegrees: Double {
        return Double(self) * 180 / .pi
    }
}
