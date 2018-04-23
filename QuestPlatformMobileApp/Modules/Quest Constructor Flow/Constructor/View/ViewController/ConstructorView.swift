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
        contentView.addSubview(tableView)
        return tableView
    }()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
