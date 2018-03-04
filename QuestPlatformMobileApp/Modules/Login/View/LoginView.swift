//
//  LoginView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        scrollView.addSubview(contentView)
        return contentView
    }()
    
    private(set) lazy var continueButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Continue", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    private(set) lazy var emailTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Email"
        contentView.addSubview(textField)
        return textField
    }()
    
    private(set) lazy var passwordTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Password"
        contentView.addSubview(textField)
        return textField
    }()
    
    private(set) lazy var errorLabel: QuestErrorLabel = {
        let label = QuestErrorLabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    
    // MARK: - UI Setup
    
    private func setupSubviews() {
        backgroundColor = .white
        
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { maker in
            let horizontalOffset: CGFloat = 24
            maker.leading.equalToSuperview().offset(horizontalOffset)
            maker.trailing.equalToSuperview().inset(horizontalOffset)
            maker.bottom.equalToSuperview().inset(52)
            maker.buttonHeight()
        }
        
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(continueButton)
            maker.bottom.equalTo(continueButton.snp.top).offset(-57)
            maker.textFieldHeight()
        }
        
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        emailTextField.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(continueButton)
            maker.bottom.equalTo(passwordTextField.snp.top).offset(-24)
            maker.textFieldHeight()
        }
        
        errorLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(passwordTextField)
            maker.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
    }
}
