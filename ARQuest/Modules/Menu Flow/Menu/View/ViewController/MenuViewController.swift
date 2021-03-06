//
//  MenuViewController.swift
//  ARQuest
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
}

// MARK: - MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    
    func menuViewDidSelectProfile(_ menuView: MenuView) {
        output.showProfile()
    }
    
    func menuViewDidSelectPublicQuests(_ menuView: MenuView) {
        output.showPublicQuests()
    }
    
    func menuViewDidSelectMyQuests(_ menuView: MenuView) {
        output.showMyQuests()
    }
    
    func menuViewDidSelectStartNewQuest(_ menuView: MenuView) {
        output.startNewQuest()
    }
    
    func menuViewDidSelectAbout(_ menuView: MenuView) {
        output.showAbout()
    }
    
    func menuViewDidSelectLogout(_ menuView: MenuView) {
        output.logout()
    }
}

// MARK: - MenuViewInput
extension MenuViewController: MenuViewInput {
    
}
