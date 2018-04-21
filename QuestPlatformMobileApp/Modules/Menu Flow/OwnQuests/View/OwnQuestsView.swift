//
//  OwnQuestsView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class OwnQuestsView: BaseView {

    override var title: String? {
        return "My Quests"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    
    // MARK: - Views
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
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
