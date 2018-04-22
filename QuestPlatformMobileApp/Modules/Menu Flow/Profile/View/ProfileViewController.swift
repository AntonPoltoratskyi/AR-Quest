//
//  ProfileViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, View {
    
    typealias Output = ProfileViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    
    // MARK: - Views
    
    private lazy var contentView: ProfileView = {
        let contentView = ProfileView()
        contentView.createButton.addTarget(self,
                                           action: #selector(actionCreateTapped(sender:)),
                                           for: .touchUpInside)
        contentView.editButton.addTarget(self,
                                         action: #selector(actionEditTapped(sender:)),
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
        swipeController.addGesture()
        output.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionCreateTapped(sender: UIButton) {
        output.didClickCreate()
    }
    
    @objc private func actionEditTapped(sender: UIButton) {
        output.didClickEdit()
    }
}

// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    
    func setupUser(_ user: User) {
        contentView.usernameLabel.text = user.name
    }
}
