//
//  ClosureTapRecognizer.swift
//  Components
//
//  Created by Anton Poltoratskyi on 30.01.18.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public final class ClosureGestureRecognizer<Recognizer: UIGestureRecognizer> {
    
    public typealias Action = (Recognizer) -> Void
    
    public let identifier: String
    public let action: Action
    
    public let recognizer: Recognizer
    
    public init(identifier: String, action: @escaping Action) {
        self.identifier = identifier
        self.action = action
        self.recognizer = Recognizer()
        self.recognizer.addTarget(self, action: #selector(handleAction(recognizer:)))
    }
    
    @objc private func handleAction(recognizer: UIGestureRecognizer) {
        guard let recognizer = recognizer as? Recognizer else { return }
        action(recognizer)
    }
}
