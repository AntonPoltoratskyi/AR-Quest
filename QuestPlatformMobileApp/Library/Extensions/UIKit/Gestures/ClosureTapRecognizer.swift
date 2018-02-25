//
//  ClosureTapRecognizer.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 11/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

class ClosureTapRecognizer: UITapGestureRecognizer {
    
    var action: ((UITapGestureRecognizer) -> Void)?
    
    init(action: ((UITapGestureRecognizer) -> Void)? = nil) {
        self.action = action
        super.init(target: self, action: #selector(tapDidRecognized(recognizer:)))
    }
    
    @objc private func tapDidRecognized(recognizer: UITapGestureRecognizer) {
        action?(recognizer)
    }
}
