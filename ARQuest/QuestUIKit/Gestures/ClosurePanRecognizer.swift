//
//  ClosurePanRecognizer.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ClosurePanRecognizer: UIPanGestureRecognizer {
    
    var targetAction: (() -> Void)? {
        didSet { self.addTarget(self, action: #selector(self.targetSelector)) }
    }
    
    @objc private func targetSelector() {
        targetAction?()
    }
}
