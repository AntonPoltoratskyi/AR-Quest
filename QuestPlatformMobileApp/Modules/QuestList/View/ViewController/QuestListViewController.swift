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
    
    private var cells: [QuestCellModel] = [] {
        didSet {
            contentView.tableView.reloadData()
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestListView = {
        let contentView = QuestListView()
            
        let tableView = contentView.tableView
        
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
        output.viewDidLoad()
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
}
