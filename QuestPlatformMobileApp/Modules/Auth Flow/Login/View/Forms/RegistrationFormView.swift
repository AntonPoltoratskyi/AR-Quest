//
//  RegistrationFormView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class RegistrationFormView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var nameTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Name"
        textField.returnKeyType = .next
        textField.keyboardType = .default
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var emailTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Email"
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var passwordTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Password"
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var confirmPasswordTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Confirm password"
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var errorLabel: QuestErrorLabel = {
        let label = QuestErrorLabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        addSubview(label)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        
        let verticalPadding = 24
        
        errorLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(confirmPasswordTextField.snp.bottom).offset(8)
            maker.height.equalTo(16)
        }
    
        confirmPasswordTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(passwordTextField.snp.bottom).offset(verticalPadding)
            maker.textFieldHeight()
        }
        
        passwordTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.textFieldHeight()
        }
    
        emailTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(passwordTextField.snp.top).offset(-verticalPadding)
            maker.textFieldHeight()
        }
        
        nameTextField.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
            maker.bottom.equalTo(emailTextField.snp.top).offset(-verticalPadding)
            maker.textFieldHeight()
        }
    }
}
