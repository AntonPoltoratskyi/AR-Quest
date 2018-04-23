//
//  TaskBuilderViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderViewController: UIViewController, View {
    
    typealias Output = TaskBuilderViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: TaskBuilderView = {
        let contentView = TaskBuilderView()
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

// MARK: - TaskBuilderViewInput
extension TaskBuilderViewController: TaskBuilderViewInput {
    
}
