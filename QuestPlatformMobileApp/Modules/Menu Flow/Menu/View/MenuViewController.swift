//
//  MenuViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import GuillotineMenu

final class MenuViewController: UIViewController, View, GuillotineMenu {
    
    typealias Output = MenuViewOutput
    var output: Output!
    
    
    // MARK: - GuillotineMenu
    
    var dismissButton: UIButton? {
        return contentView.navigationView.leftBarButton
    }
    
    var titleLabel: UILabel? {
        return contentView.navigationView.titleLabel
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: MenuView = {
        let contentView = MenuView()
        contentView.navigationView.setupLeftButton(title: "Q") { [weak self] sender in
            self?.dismiss(animated: true, completion: nil)
        }
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
