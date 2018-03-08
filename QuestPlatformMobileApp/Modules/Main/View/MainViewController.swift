//
//  MainViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol MainViewInput: class {
}

protocol MainViewOutput: class {
}

final class MainViewController: UIViewController, View {
    
    typealias Output = MainViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: MainView = {
        let contentView = MainView()
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

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    
}
