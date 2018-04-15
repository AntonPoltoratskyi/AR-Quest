//
//  QuestListViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestListViewController: UIViewController, View {
    
    typealias Output = QuestListViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    private var cells: [QuestCellModel] = [] {
        didSet {
            contentView.tableView.reloadData()
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestListView = {
        let contentView = QuestListView()
            
        let tableView = contentView.tableView
        
        tableView.register(headerFooter: CodeInputHeaderView.self)
        tableView.sectionHeaderHeight = CodeInputHeaderView.Layout.height
        
        tableView.register(viewModel: QuestCellModel.self)
        tableView.rowHeight = QuestCellModel.Cell.Layout.height
        tableView.dataSource = self
        tableView.delegate = self
        
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeController.addGesture()
        output.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionJoinByCode(sender: UIButton) {
        output.didClickJoinByCode()
    }
}

// MARK: - QuestListViewInput
extension QuestListViewController: QuestListViewInput {
    
    func setupQuests(_ models: [QuestCellModel]) {
        self.cells = models
    }
}

// MARK: - Table View
extension QuestListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: cellModel(at: indexPath), for: indexPath)
    }
    
    private func cellModel(at indexPath: IndexPath) -> QuestCellModel {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(ofType: CodeInputHeaderView.self)
        headerView.joinButton.addTarget(self, action: #selector(actionJoinByCode(sender:)), for: .touchUpInside)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedModel = cellModel(at: indexPath)
        output.didSelectQuest(selectedModel)
    }
}
