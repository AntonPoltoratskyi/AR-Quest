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
    
    private(set) lazy var emailTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Email"
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var passwordTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Password"
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var confirmPasswordTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Confirm password"
        addSubview(textField)
        return textField
    }()
    
    private(set) lazy var errorLabel: QuestErrorLabel = {
        let label = QuestErrorLabel()
        label.textAlignment = .center
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
        
        errorLabel.setContentHuggingPriority(.required, for: .vertical)
        errorLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(confirmPasswordTextField.snp.bottom).offset(8)
            maker.height.equalTo(16)
        }
        
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(passwordTextField.snp.bottom).offset(verticalPadding)
            maker.textFieldHeight()
        }
        
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.textFieldHeight()
        }
        
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
            maker.bottom.equalTo(passwordTextField.snp.top).offset(-verticalPadding)
            maker.textFieldHeight()
        }
    }
}
