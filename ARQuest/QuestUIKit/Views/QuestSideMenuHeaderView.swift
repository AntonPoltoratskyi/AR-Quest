//
//  QuestSideMenuHeaderView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestSideMenuHeaderView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        addSubview(backgroundView)
        return backgroundView
    }()
    
    private(set) lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        addSubview(blurView)
        return blurView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        clipsToBounds = true
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
