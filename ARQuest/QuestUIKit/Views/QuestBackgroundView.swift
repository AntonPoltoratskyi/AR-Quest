//
//  QuestBackgroundView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestBackgroundView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var circleView: QuestCircleView = {
        let backgroundCircleView = QuestCircleView()
        backgroundCircleView.backgroundColor = Theme.Background.blueBackground
        addSubview(backgroundCircleView)
        return backgroundCircleView
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
        circleView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview().offset(-40)
            maker.centerX.equalTo(self.snp.trailing)
            maker.width.height.equalTo(self.snp.width)
        }
    }
}
