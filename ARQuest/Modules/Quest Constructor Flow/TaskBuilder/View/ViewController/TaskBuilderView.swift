//
//  TaskBuilderView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderView: BaseScrollableView {
    
    override var title: String? {
        return "New Task"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    // MARK: - Views
    
    private(set) lazy var titleField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Enter title"
        contentView.addSubview(textField)
        return textField
    }()
    
    private(set) lazy var segmentedControl: QuestSegmentedControl = {
        let actions: [ControlAction] = [
            ControlAction(title: "Text Hint") { [unowned self] in
                self.textFormView.isHidden = false
                self.locationFormView.isHidden = true
            },
            ControlAction(title: "Location") { [unowned self] in
                self.textFormView.isHidden = true
                self.locationFormView.isHidden = false
            }
        ]
        let control = QuestSegmentedControl(actions: actions)
        contentView.addSubview(control)
        return control
    }()
    
    private(set) lazy var textFormView: TextHintFormView = {
        let textFormView = TextHintFormView()
        contentView.addSubview(textFormView)
        return textFormView
    }()
    
    private(set) lazy var locationFormView: LocationTaskFormView = {
        let locationFormView = LocationTaskFormView()
        contentView.addSubview(locationFormView)
        return locationFormView
    }()
    
    private(set) lazy var doneButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Done", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        textFormView.isHidden = false
        locationFormView.isHidden = true
        
        titleField.snp.makeConstraints { maker in
            maker.top.equalTo(self.navigationView.snp.bottom).offset(16)
            maker.horizontalInset(16)
            maker.textFieldHeight()
        }
        
        segmentedControl.snp.makeConstraints { maker in
            maker.top.equalTo(self.titleField.snp.bottom).offset(16)
            maker.leading.trailing.equalToSuperview()
            maker.segmentedControlActionHeight()
        }
        
        textFormView.snp.makeConstraints { maker in
            maker.top.equalTo(segmentedControl.snp.bottom).offset(16)
            maker.horizontalInset(16)
            maker.bottom.equalTo(doneButton.snp.top).offset(-16)
        }
        
        locationFormView.snp.makeConstraints { maker in
            maker.top.equalTo(segmentedControl.snp.bottom).offset(16)
            maker.horizontalInset(16)
            maker.bottom.equalTo(doneButton.snp.top).offset(-16)
        }
        
        doneButton.snp.makeConstraints { maker in
            maker.horizontalInset(16)
            maker.buttonHeight()
            maker.bottom.equalToSuperview().inset(16)
        }
    }
}
