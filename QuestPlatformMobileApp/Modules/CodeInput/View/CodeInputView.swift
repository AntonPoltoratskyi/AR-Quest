//
//  CodeInputView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputView: UIView {
    
    // MARK: - Views
    
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
    
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        contentView.addSubview(backgroundView)
        return backgroundView
    }()
    
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
        backgroundColor = .white
        
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        
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
