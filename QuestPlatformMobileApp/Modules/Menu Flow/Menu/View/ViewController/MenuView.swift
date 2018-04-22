//
//  MenuView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuViewDelegate: class {
    func menuViewDidSelectProfile(_ menuView: MenuView)
    func menuViewDidSelectMyQuests(_ menuView: MenuView)
    func menuViewDidSelectStartNewQuest(_ menuView: MenuView)
    func menuViewDidSelectAbout(_ menuView: MenuView)
    func menuViewDidSelectLogout(_ menuView: MenuView)
}

final class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    
    private lazy var menuItems: [MenuItemCellModel] = {
        return [
            MenuItemCellModel(title: "Profile") { [unowned self] in
                self.delegate?.menuViewDidSelectProfile(self)
            },
            MenuItemCellModel(title: "My Quests") { [unowned self] in
                self.delegate?.menuViewDidSelectMyQuests(self)
            },
            MenuItemCellModel(title: "Start New") { [unowned self] in
                self.delegate?.menuViewDidSelectStartNewQuest(self)
            },
            MenuItemCellModel(title: "About") { [unowned self] in
                self.delegate?.menuViewDidSelectAbout(self)
            },
            MenuItemCellModel(title: "Sign Out") { [unowned self] in
                self.delegate?.menuViewDidSelectLogout(self)
            }
        ]
    }()
    
    
    // MARK: - Views
    
    private(set) lazy var headerView: QuestSideMenuHeaderView = {
        let headerView = QuestSideMenuHeaderView()
        addSubview(headerView)
        return headerView
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(viewModel: MenuItemCellModel.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView()
        
        addSubview(tableView)
        return tableView
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
        backgroundColor = .white
        
        headerView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.sideMenuHeaderHeight()
        }
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(headerView.snp.bottom)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Table View
extension MenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: menuItem(at: indexPath), for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuItem(at: indexPath)
        item.handler()
    }
    
    private func menuItem(at indexPath: IndexPath) -> MenuItemCellModel {
        return menuItems[indexPath.row]
    }
}
