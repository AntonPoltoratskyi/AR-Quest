//
//  TaskTableHeaderView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskTableHeaderView: UITableViewHeaderFooterView, Reusable {
    
    var handler: ((UIButton) -> Void)?
    
    // MARK: - Views
    
    private(set) lazy var taskButton: QuestButton = {
        let taskButton = QuestButton()
        taskButton.setTitle("Add Task", for: .normal)
        taskButton.addTarget(self, action: #selector(actionTaskButtonTapped(sender:)), for: .touchUpInside)
        contentView.addSubview(taskButton)
        return taskButton
    }()
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        let view = UIView()
        view.backgroundColor = .clear
        backgroundView = view
        
        taskButton.snp.makeConstraints { maker in
            maker.horizontalInset(32)
            maker.centerY.equalToSuperview()
            maker.buttonHeight()
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func actionTaskButtonTapped(sender: UIButton) {
        handler?(sender)
    }
}

// MARK: - Layout
extension TaskTableHeaderView {
    enum Layout {
        static let height: CGFloat = 60
    }
}
