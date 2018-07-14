//
//  QuestButton.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class QuestButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor =  Theme.Button.Color.lightBlue
            } else {
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor =  Theme.Button.Color.lightBlueHighlighted
            } else if isEnabled {
                backgroundColor =  Theme.Button.Color.lightBlue
            } else {
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        backgroundColor = Theme.Button.Color.lightBlue
        layer.cornerRadius = 12
        titleLabel?.font = Theme.Button.Font.default
        setTitleColor(Theme.Button.Color.title, for: .normal)
    }
}
