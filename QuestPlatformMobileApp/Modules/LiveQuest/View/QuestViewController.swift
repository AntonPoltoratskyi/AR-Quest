//
//  QuestViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestViewController: UIViewController, View {
    
    typealias Output = QuestViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestView = {
        let contentView = QuestView()
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

// MARK: - QuestViewInput
extension QuestViewController: QuestViewInput {
    
}
