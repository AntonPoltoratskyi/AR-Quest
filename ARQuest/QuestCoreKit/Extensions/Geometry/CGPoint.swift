//
//  CGPoint.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/13/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

extension CGPoint {
    func translated(byX x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}
