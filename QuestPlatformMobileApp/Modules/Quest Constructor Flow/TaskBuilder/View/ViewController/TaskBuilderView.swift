//
//  TaskBuilderView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderView: BaseView {
    
    override var title: String? {
        return "New Task"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    // MARK: - Views
    
    private(set) lazy var segmentedControl: QuestSegmentedControl = {
        let actions: [ControlAction] = [
            ControlAction(title: "Question") { [unowned self] in
                
            },
            ControlAction(title: "Location") { [unowned self] in
                
            }
        ]
        let control = QuestSegmentedControl(actions: actions)
        contentView.addSubview(control)
        return control
    }()
    
    private(set) lazy var questionFormView: QuestionTaskFormView = {
        let questionFormView = QuestionTaskFormView()
        contentView.addSubview(questionFormView)
        return questionFormView
    }()
    
    private(set) lazy var locationFormView: LocationTaskFormView = {
        let locationFormView = LocationTaskFormView()
        contentView.addSubview(locationFormView)
        return locationFormView
    }()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        segmentedControl.snp.makeConstraints { maker in
            maker.top.equalTo(self.navigationView.snp.bottom).offset(8)
            maker.leading.trailing.equalToSuperview()
            maker.segmentedControlActionHeight()
        }
    }
}
