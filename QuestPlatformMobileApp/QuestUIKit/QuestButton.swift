//
//  QuestButton.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class QuestButton: UIButton {
    
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
