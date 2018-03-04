//
//  ClosureTapRecognizer.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public final class ClosureTapRecognizer: UITapGestureRecognizer {
    
    public let identifier: String
    public var action: ((UITapGestureRecognizer) -> Void)?
    
    public init(identifier: String, action: ((UITapGestureRecognizer) -> Void)? = nil) {
        self.identifier = identifier
        self.action = action
        super.init(target: self, action: #selector(tapDidRecognized(recognizer:)))
    }
    
    @objc private func tapDidRecognized(recognizer: UITapGestureRecognizer) {
        action?(recognizer)
    }
}
