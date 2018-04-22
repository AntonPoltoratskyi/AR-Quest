//
//  EditProfileViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class EditProfileViewController: UIViewController, View {
    
    typealias Output = EditProfileViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    
    // MARK: - Views
    
    private lazy var contentView: EditProfileView = {
        let contentView = EditProfileView()
        contentView.saveButton.addTarget(self,
                                         action: #selector(actionSaveButtonTapped(sender:)),
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
    
    @objc private func actionSaveButtonTapped(sender: UIButton) {
        let username = contentView.usernameTextField.text ?? ""
        let userInfo = EditUserInfo(username: username)
        output.didClickSave(userInfo: userInfo)
    }
}

// MARK: - EditProfileViewInput
extension EditProfileViewController: EditProfileViewInput {
    
    func setup(with user: User) {
        contentView.usernameTextField.text = user.name
    }
}
