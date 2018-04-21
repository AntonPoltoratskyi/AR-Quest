//
//  MenuViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController, View {
    
    typealias Output = MenuViewOutput
    var output: Output!
    
    // MARK: - Views
    
    private lazy var contentView: MenuView = {
        let contentView = MenuView()
        contentView.delegate = self
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
    
    
    // MARK: - Actions
    
    @objc private func actionDismiss(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    
    func menuViewDidSelectProfile(_ menuView: MenuView) {
        
    }
    
    func menuViewDidSelectMyQuests(_ menuView: MenuView) {
        
    }
    
    func menuViewDidSelectStartNewQuest(_ menuView: MenuView) {
        
    }
    
    func menuViewDidSelectAbout(_ menuView: MenuView) {
        
    }
    
    func menuViewDidSelectLogout(_ menuView: MenuView) {
        
    }
}

// MARK: - MenuViewInput
extension MenuViewController: MenuViewInput {
    
}
