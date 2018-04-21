//
//  ProfileView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileView: BaseView {
    
    // MARK: - Views
    
    override var isNavigationViewVisible: Bool {
        return false
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var avatarImageView: QuestRoundImageView = {
        let imageView = QuestRoundImageView()
        imageView.backgroundColor = Theme.Avatar.placeholder
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var createButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Become a creator", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    private(set) lazy var editButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Edit Profile", for: .normal)
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
        
        usernameLabel.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.username.horizontalInset)
            maker.bottom.equalTo(createButton.snp.top).offset(-Layout.username.bottom)
        }
        
        createButton.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.createButton.horizontalInset)
            maker.bottom.equalTo(editButton.snp.top).offset(-Layout.createButton.bottom)
            maker.buttonHeight()
        }
        
        editButton.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.editButton.horizontalInset)
            maker.bottom.equalToSuperview().offset(-Layout.editButton.bottom)
            maker.buttonHeight()
        }
    }
}

// MARK: - Layout
extension ProfileView {
    
    enum Layout {
        enum avatar {
            static let size: CGFloat = 200
            static let top: CGFloat = 64
        }
        enum username {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 16
        }
        enum createButton {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 16
        }
        enum editButton {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 75
        }
    }
}
