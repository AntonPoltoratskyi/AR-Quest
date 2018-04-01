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
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestListView = {
        let contentView = QuestListView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - QuestListViewInput
extension QuestListViewController: QuestListViewInput {
    
}
