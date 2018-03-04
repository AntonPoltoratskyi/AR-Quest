//
//  QuestSegmentedControl.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class ControlAction {
    var title: String
    var handler: () -> Void
    
    init(title: String, handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
    }
}

class QuestSegmentedControl: UIView {
    
    private(set) var actions: [ControlAction] = []
    private var handlers: [UIButton: ControlAction] = [:]
    
    private var actionButtons: [UIButton] {
        return self.handlers.keys.map { $0 }
    }
    
    private(set) lazy var actionsContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        self.addSubview(containerView)
        return containerView
    }()
    
    
    // MARK: - Init
    
    init(actions: [ControlAction]) {
        self.actions = actions
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .clear
        
        actionsContainerView.snp.makeConstraints { maker in
            maker.top.bottom.centerX.equalToSuperview()
            maker.leading.greaterThanOrEqualToSuperview()
            maker.trailing.lessThanOrEqualToSuperview()
        }
        setup(actions: actions, in: actionsContainerView)
        
        let buttons = self.actionButtons
        buttons.setEqualHeight()
        buttons.setEqualWidth()
        
        buttons.first?.snp.makeConstraints { maker in
            maker.width.equalTo(Constraints.buttons.width)
        }
        
        selectAction(at: 0)
    }
    
    private func setup(actions: [ControlAction], in container: UIView) {
        guard let firstAction = actions.first else { return }
        
        let firstButton = createControl(for: firstAction)
        container.addSubview(firstButton)
        
        firstButton.snp.makeConstraints { maker in
            maker.top.bottom.left.equalToSuperview()
        }
        
        var previousButton = firstButton
        
        for action in actions.dropFirst() {
            let actionButton = createControl(for: action)
            container.addSubview(actionButton)
            
            actionButton.snp.makeConstraints { maker in
                maker.top.bottom.equalToSuperview()
                maker.left.equalTo(previousButton.snp.right).offset(Constraints.buttons.horizontalPadding)
            }
            previousButton = actionButton
        }
        
        previousButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview()
        }
    }
    
    private func createControl(for action: ControlAction) -> UIButton {
        let button = UIButton()
        button.setTitle(action.title, for: .normal)
        button.titleLabel?.font = Theme.SegmentedControl.Font.default
        
        button.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = false

        self.addSubview(button)
        
        self.handlers[button] = action
        
        return button
    }
    
    
    // MARK: - Actions
    
    func selectAction(at index: Int) {
        guard self.actions.indices.contains(index) else { return }
        
        let selectedAction = self.actions[index]
        selectAction(selectedAction)
    }
    
    func selectAction(_ selectedAction: ControlAction) {
        for (button, action) in self.handlers {
            if action === selectedAction {
                button.backgroundColor = Theme.SegmentedControl.Color.selectedColor
                button.setTitleColor(Theme.SegmentedControl.Color.selectedTextColor, for: .normal)
            } else {
                button.backgroundColor = Theme.SegmentedControl.Color.normalColor
                button.setTitleColor(Theme.SegmentedControl.Color.normalTextColor, for: .normal)
            }
        }
    }
    
    @objc private func actionButtonTapped(_ sender: UIButton) {
        guard let action = self.handlers[sender] else { return }
        selectAction(action)
        action.handler()
    }
}

// MARK: - Layout

extension QuestSegmentedControl {
    
    enum Constraints {
        
        enum buttons {
            static let horizontalPadding: CGFloat = 24
            static let width: CGFloat = 80
        }
    }
}
