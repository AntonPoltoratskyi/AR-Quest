//
//  ConstructorViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorViewController: UIViewController, View {
    
    typealias Output = ConstructorViewOutput
    var output: Output!
    
    private var tasks: [QuestTaskCellModel] = []
    
    
    // MARK: - Views
    
    private lazy var contentView: ConstructorView = {
        let contentView = ConstructorView()
        
        let tableView = contentView.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(viewModel: QuestTaskCellModel.self)
        tableView.rowHeight = QuestTaskCellModel.Cell.Layout.height
        tableView.estimatedRowHeight = tableView.rowHeight
        
        contentView.navigationView.setupRightButton(title: "Edit") { [unowned tableView] sender in
            let isEditing = !tableView.isEditing
            let title = isEditing ? "Done" : "Edit"
            
            tableView.setEditing(isEditing, animated: true)
            sender.setTitle(title, for: .normal)
        }
        
        contentView.addTaskButton.addTarget(self,
                                            action: #selector(actionCreateTask(sender:)),
                                            for: .touchUpInside)
        
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.reloadData()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionCreateTask(sender: Any) {
        output.didClickAddTask()
    }
}

// MARK: - ConstructorViewInput
extension ConstructorViewController: ConstructorViewInput {
    
    func addTask(_ task: QuestTaskCellModel) {
        tasks.append(task)
        contentView.tableView.reloadData()
    }
}

// MARK: - Table View
extension ConstructorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = tasks.count
        count > 0 ? removeBackgoundView(for: tableView) : setupBackgroundView(for: tableView)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: task(at: indexPath), for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tasks.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    private func setupBackgroundView(for tableView: UITableView) {
        let backgroundView = UIView()
        backgroundView.addSubview(contentView.addTaskButton)
        tableView.backgroundView = backgroundView
        
        contentView.addTaskButton.snp.removeConstraints()
        contentView.addTaskButton.snp.makeConstraints { maker in
            maker.horizontalInset(32)
            maker.centerY.equalToSuperview()
            maker.buttonHeight()
        }
    }
    
    private func removeBackgoundView(for tableView: UITableView) {
        tableView.backgroundView = nil
    }
    
    private func task(at indexPath: IndexPath) -> QuestTaskCellModel {
        return tasks[indexPath.row]
    }
}
