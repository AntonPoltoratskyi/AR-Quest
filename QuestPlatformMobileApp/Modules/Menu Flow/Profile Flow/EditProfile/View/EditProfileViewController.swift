//
//  EditProfileViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class EditProfileViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = EditProfileViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    var keyboardInputViews: [KeyboardInputView] {
        return [contentView.usernameTextField]
    }
    
    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
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
        keyboardInputViews.compactMap { $0 as? UITextField }.forEach { $0.delegate = self }
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionSaveButtonTapped(sender: UIButton) {
        let username = contentView.usernameTextField.text ?? ""
        let userInfo = EditUserInfo(username: username)
        output.didClickSave(userInfo: userInfo)
    }
}

// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleNextInput(textField)
        return true
    }
}

// MARK: - EditProfileViewInput
extension EditProfileViewController: EditProfileViewInput {
    
    func setup(with user: User) {
        contentView.usernameTextField.text = user.name
    }
}
