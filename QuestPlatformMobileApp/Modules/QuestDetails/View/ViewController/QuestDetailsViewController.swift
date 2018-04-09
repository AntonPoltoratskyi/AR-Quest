//
//  QuestDetailsViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestDetailsViewController: UIViewController, View {
    
    typealias Output = QuestDetailsViewOutput
    var output: Output!
    
    private var cells: [QuestTaskCellModel] = [] {
        didSet {
            contentView.tableView.reloadData()
            contentView.tableView.layoutIfNeeded()
            
            let height = contentView.tableView.contentSize.height
            contentView.tableView.snp.updateConstraints { maker in
                maker.height.equalTo(height)
            }
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestDetailsView = {
        let contentView = QuestDetailsView()
        
        let tableView = contentView.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(viewModel: QuestTaskCellModel.self)
        tableView.rowHeight = QuestTaskCellModel.Cell.Layout.height
        tableView.estimatedRowHeight = tableView.rowHeight
        
        contentView.joinButton.addTarget(self, action: #selector(actionJoin(sender:)), for: .touchUpInside)
        
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
    
    
    // MARK: - Actions
    
    @objc private func actionJoin(sender: UIButton) {
        output.didClickJoin()
    }
}

// MARK: - QuestDetailsViewInput
extension QuestDetailsViewController: QuestDetailsViewInput {
    
    func setupQuestInfo(_ quest: Quest) {
        contentView.questNameLabel.text = quest.name
    }
    
    func setupTasks(_ models: [QuestTaskCellModel]) {
        cells = models
    }
}

// MARK: - Table View
extension QuestDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: cellModel(at: indexPath), for: indexPath)
    }
    
    private func cellModel(at indexPath: IndexPath) -> QuestTaskCellModel {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
