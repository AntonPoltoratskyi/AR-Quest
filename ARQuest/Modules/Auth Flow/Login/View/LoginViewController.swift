//
//  LoginViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LoginViewInput: class {
    func showError(_ errorMessage: String)
}

protocol LoginViewOutput: class {
    func didClickSignIn(email: String?, password: String?)
    func didClickSignUp(name: String?, email: String?, password: String?, confirmationPassword: String?)
}

final class LoginViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = LoginViewOutput
    var output: Output!
    
    enum State {
        case signIn
        case signUp
    }
    private var state: State = .signIn {
        didSet {
            keyboardInputViews.compactMap { $0 as? UITextField }.forEach { $0.delegate = self }
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: LoginView = {
        let contentView = LoginView()
        contentView.continueButton.addTarget(self, action: #selector(actionLogin(sender:)), for: .touchUpInside)
        contentView.delegate = self
        return contentView
    }()
    
    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
    var keyboardInputViews: [KeyboardInputView] {
        switch state {
        case .signIn:
            return [contentView.loginForm.emailTextField, contentView.loginForm.passwordTextField]
        case .signUp:
            return [contentView.registrationForm.nameTextField, contentView.registrationForm.emailTextField, contentView.registrationForm.passwordTextField, contentView.registrationForm.confirmPasswordTextField]
        }
    }
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
        self.state = .signIn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            contentView.loginForm.emailTextField.text = "testpolant@gmail.com"
            contentView.loginForm.passwordTextField.text = "qwerty123"
        #endif
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
        switch self.state {
        case .signIn:
            let email = contentView.loginForm.emailTextField.text
            let password = contentView.loginForm.passwordTextField.text
            output.didClickSignIn(email: email, password: password)
        case .signUp:
            let name = contentView.registrationForm.nameTextField.text
            let email = contentView.registrationForm.emailTextField.text
            let password = contentView.registrationForm.passwordTextField.text
            let confirmationPassword = contentView.registrationForm.confirmPasswordTextField.text
            output.didClickSignUp(name: name, email: email, password: password, confirmationPassword: confirmationPassword)
        }
    }
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    
    func loginViewDidSelectSignIn(_ loginView: LoginView) {
        self.state = .signIn
        contentView.showLoginForm()
    }
    
    func loginViewDidSelectSignUp(_ loginView: LoginView) {
        self.state = .signUp
        contentView.showSignUpForm()
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleNextInput(textField)
        return true
    }
}

// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    
    func showError(_ errorMessage: String) {
        switch self.state {
        case .signIn:
            contentView.loginForm.errorLabel.text = "*\(errorMessage)"
        case .signUp:
            contentView.registrationForm.errorLabel.text = "*\(errorMessage)"
        }
    }
}
