//
//  FloatingPoint+Extensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

typealias Radians = Double

extension FloatingPoint {
    var degreesToRadians: Self { return self / 180 * .pi }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
