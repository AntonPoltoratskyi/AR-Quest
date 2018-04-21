//
//  OwnQuestsViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class OwnQuestsViewController: UIViewController, View {
    
    typealias Output = OwnQuestsViewOutput
    var output: Output!
    
    private var cells: [QuestCellModel] = [] {
        didSet {
            contentView.tableView.reloadData()
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: OwnQuestsView = {
        let contentView = OwnQuestsView()
        
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
        output.viewDidLoad()
    }
}

// MARK: - OwnQuestsViewInput
extension OwnQuestsViewController: OwnQuestsViewInput {
    
    func setupQuests(_ models: [QuestCellModel]) {
        self.cells = models
    }
}

// MARK: - Table View
extension OwnQuestsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: cellModel(at: indexPath), for: indexPath)
    }
    
    private func cellModel(at indexPath: IndexPath) -> QuestCellModel {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedModel = cellModel(at: indexPath)
        output.didSelectQuest(selectedModel)
    }
}
