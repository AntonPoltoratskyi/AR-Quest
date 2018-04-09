//
//  QuestRoundImageView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestRoundImageView: UIImageView {
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}
