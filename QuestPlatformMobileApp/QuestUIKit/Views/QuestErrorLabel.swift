//
//  QuestErrorLabel.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

class QuestErrorLabel: UILabel {
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    
    // MARK: - UI Setup
    
    private func setupSubviews() {
        textColor = Theme.Label.Color.error
        font = Theme.Label.Font.error
    }
}
