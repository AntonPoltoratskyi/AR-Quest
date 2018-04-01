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
    }
}

// MARK: - QuestDetailsViewInput
extension QuestDetailsViewController: QuestDetailsViewInput {
    
}
