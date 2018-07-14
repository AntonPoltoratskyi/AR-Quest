//
//  QuestInfoPopupView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestInfoPopupView: BaseScrollableView {
    
    var accessLevelSelectionHandler: ((Quest.AccessLevel) -> Void)?
    
    
    // MARK: - Views
    
    override var isNavigationViewVisible: Bool {
        return false
    }

    private(set) lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = Theme.NavigationView.Color.backgroundColor.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.backgroundColor = .white
        
        addSubview(containerView)
        return containerView
    }()
    
    private(set) lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        contentView.addSubview(blurView)
        return blurView
    }()
    
    private(set) lazy var titleField: QuestTextField = {
        let titleField = QuestTextField()
        titleField.placeholder = "Enter Title"
        containerView.addSubview(titleField)
        return titleField
    }()
    
    private(set) lazy var segmentedControl: QuestSegmentedControl = {
        let actions: [ControlAction] = [
            ControlAction(title: "Public") { [unowned self] in
                self.accessLevelSelectionHandler?(.public)
            },
            ControlAction(title: "Private") { [unowned self] in
                self.accessLevelSelectionHandler?(.private)
            }
        ]
        let control = QuestSegmentedControl(actions: actions)
        containerView.addSubview(control)
        return control
    }()
    
    private(set) lazy var saveButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Save", for: .normal)
        containerView.addSubview(button)
        return button
    }()
    

    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        
//        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        blurView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { maker in
            maker.horizontalInset(16)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.height * 0.7)
        }
        
        titleField.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(16)
            maker.horizontalInset(8)
            maker.textFieldHeight()
        }
        
        segmentedControl.snp.makeConstraints { maker in
            maker.horizontalInset(8)
            maker.top.equalTo(titleField.snp.bottom).offset(16)
            maker.segmentedControlActionHeight()
        }
        
        saveButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(16)
            maker.horizontalInset(8)
            maker.buttonHeight()
        }
    }
}
