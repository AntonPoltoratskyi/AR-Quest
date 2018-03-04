//
//  MenuViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol MenuViewInput: class {
}

protocol MenuViewOutput: class {
}

final class MenuViewController: UIViewController, View {
    
    typealias Output = MenuViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: MenuView = {
        let contentView = MenuView()
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

// MARK: - MenuViewInput
extension MenuViewController: MenuViewInput {
    
}
