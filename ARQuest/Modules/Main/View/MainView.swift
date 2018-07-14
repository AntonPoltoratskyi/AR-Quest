//
//  MainView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    // MARK: - Views
    
    override var title: String? {
        return "Quest"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var textContainerView: UIView = {
        let containerView = UIView()
        contentView.addSubview(containerView)
        return containerView
    }()
    
    private(set) lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = Layout.Fonts.countFont
        label.textColor = Layout.Colors.textColor
        label.textAlignment = .center
        textContainerView.addSubview(label)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Layout.Fonts.descriptionFont
        label.textColor = Layout.Colors.textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        textContainerView.addSubview(label)
        return label
    }()
    
    private(set) lazy var joinButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Join", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    

    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        textContainerView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.horizontalInset(16)
        }
        
        countLabel.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(countLabel.snp.bottom).offset(4)
            maker.left.right.bottom.equalToSuperview()
        }
        
        joinButton.snp.makeConstraints { maker in
            maker.horizontalInset(16)
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(64)
            maker.buttonHeight()
        }
    }
}

// MARK: - Layout

extension MainView {
    
    enum Layout {
        enum Fonts {
            static let countFont = UIFont.appFont(ofSize: 64, weight: .medium)
            static let descriptionFont = UIFont.appFont(ofSize: 18, weight: .medium)
        }
        enum Colors {
            static let textColor = UIColor.darkText
        }
    }
}
