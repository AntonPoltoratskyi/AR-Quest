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
    
    private var cells: [QuestTaskCellModel] = []
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestDetailsView = {
        let contentView = QuestDetailsView()
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

// MARK: - QuestDetailsViewInput
extension QuestDetailsViewController: QuestDetailsViewInput {
    
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
}
