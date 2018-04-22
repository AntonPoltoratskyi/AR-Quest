//
//  CodeInputView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputView: BaseScrollableView {
    
    // MARK: - Views
    
    override var title: String? {
        return "By Code"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var inputTextField: QuestTextField = {
        let inputTextField = QuestTextField()
        inputTextField.placeholder = "Enter your code"
        inputTextField.delegate = self
        inputTextField.returnKeyType = .done
        contentView.addSubview(inputTextField)
        return inputTextField
    }()
    
    private(set) lazy var errorLabel: QuestErrorLabel = {
        let label = QuestErrorLabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var joinButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Join", for: .normal)
        contentView.addSubview(button)
        return button
    }()

    
    // MARK: - Setup
    
    override func setup() {
        super.setup()

        inputTextField.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.horizontalInset(Layout.inputTextField.horizontalInset)
            maker.textFieldHeight()
        }
        
        errorLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(inputTextField.snp.bottom).offset(8)
            maker.height.equalTo(16)
        }
        
        joinButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(64)
            maker.horizontalInset(Layout.joinButton.horizontalInset)
            maker.buttonHeight()
        }
    }
}

// MARK: - UITextFieldDelegate

extension CodeInputView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Layout

extension CodeInputView {
    
    enum Layout {
        
        enum inputTextField {
            static let horizontalInset: CGFloat = 16
        }
        
        enum joinButton {
            static let horizontalInset: CGFloat = 16
        }
    }
}
