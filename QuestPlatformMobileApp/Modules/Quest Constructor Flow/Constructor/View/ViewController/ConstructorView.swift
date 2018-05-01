//
//  ConstructorView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorView: BaseView {
    
    // MARK: - Views
    
    override var title: String? {
        return "Constructor"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 16
        contentView.addSubview(tableView)
        return tableView
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
        
        tableView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { maker in
            maker.top.equalTo(tableView.snp.bottom)
            maker.horizontalInset(16)
            maker.buttonHeight()
            maker.bottom.equalToSuperview().inset(16)
        }
    }
}
