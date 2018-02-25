//
//  LoginViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LoginViewInput: class {
}

protocol LoginViewOutput: class {
}

final class LoginViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = LoginViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: LoginView = {
        let contentView = LoginView()
        contentView.continueButton.addTarget(self, action: #selector(actionLogin(sender:)), for: .touchUpInside)
        return contentView
    }()
    
    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
    var keyboardInputViews: [KeyboardInputView] {
        return [contentView.emailTextField, contentView.passwordTextField]
    }
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
        keyboardInputViews
            .flatMap { $0 as? UITextField }
            .forEach { $0.delegate = self }
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
    
    @objc private func actionLogin(sender: UIButton) {
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let inputViews = keyboardInputViews
        if let index = inputViews.index(where: { $0 === textField }) {
            if index + 1 < inputViews.endIndex {
                inputViews[index + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return true
    }
}

// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    
}
