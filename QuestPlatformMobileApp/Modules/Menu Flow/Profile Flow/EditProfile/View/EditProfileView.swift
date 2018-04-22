//
//  EditProfileView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class EditProfileView: BaseView {
    
    // MARK: - Views
    
    override var isNavigationViewVisible: Bool {
        return false
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var avatarImageView: QuestRoundImageView = {
        let imageView = QuestRoundImageView()
        imageView.backgroundColor = Theme.Avatar.placeholderBackground
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Theme.Avatar.placeholderBorder.cgColor
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var usernameTextField: QuestTextField = {
        let textField = QuestTextField()
        textField.placeholder = "Enter username"
        contentView.addSubview(textField)
        return textField
    }()
    
    private(set) lazy var saveButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Save", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        avatarImageView.layer.cornerRadius = Layout.avatar.size / 2
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Layout.avatar.top)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(Layout.avatar.size)
        }
        
        usernameTextField.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.usernameField.horizontalInset)
            maker.bottom.equalTo(saveButton.snp.top).offset(-Layout.usernameField.bottom)
            maker.textFieldHeight()
        }
        
        saveButton.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.saveButton.horizontalInset)
            maker.bottom.equalToSuperview().inset(Layout.saveButton.bottom)
            maker.buttonHeight()
        }
    }
}

// MARK: - Layout
extension EditProfileView {
    
    enum Layout {
        enum avatar {
            static let size: CGFloat = 160
            static let top: CGFloat = 64
        }
        enum usernameField {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 57
        }
        enum saveButton {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 75
        }
    }
}
