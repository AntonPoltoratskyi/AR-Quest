//
//  FloatingPoint+Extensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    static var goldenSection: CGFloat { return 1.62 }
}

extension Double {
    func relativeHeight() -> Double {
        return sqrt(self) * 5
    }
}

extension FloatingPoint {
    var degToRad: Self { return self / 180 * .pi }
    var radToDeg: Self { return self * 180 / .pi }
}

