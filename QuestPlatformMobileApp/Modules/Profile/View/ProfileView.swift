//
//  ProfileView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        addSubview(backgroundView)
        return backgroundView
    }()
    
    private(set) lazy var avatarImageView: QuestRoundImageView = {
        let imageView = QuestRoundImageView()
        addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        return label
    }()
    
    private(set) lazy var createButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Become a creator", for: .normal)
        addSubview(button)
        return button
    }()
    
    private(set) lazy var editButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Edit Profile", for: .normal)
        addSubview(button)
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
        
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Layout.avatar.top)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(Layout.avatar.size)
        }
        
        usernameLabel.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.username.horizontalInset)
            maker.top.equalTo(avatarImageView.snp.bottom).offset(Layout.username.top)
        }
        
        createButton.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.createButton.horizontalInset)
            maker.top.equalTo(usernameLabel.snp.bottom).offset(Layout.createButton.top)
            maker.buttonHeight()
        }
        
        editButton.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.editButton.horizontalInset)
            maker.top.equalTo(createButton.snp.bottom).offset(Layout.editButton.top)
            maker.buttonHeight()
        }
    }
}

// MARK: - Layout
extension ProfileView {
    
    enum Layout {
        enum avatar {
            static let size: CGFloat = 64
            static let top: CGFloat = 48
        }
        enum username {
            static let top: CGFloat = 48
            static let horizontalInset: CGFloat = 16
        }
        enum createButton {
            static let top: CGFloat = 48
            static let horizontalInset: CGFloat = 16
        }
        enum editButton {
            static let top: CGFloat = 16
            static let horizontalInset: CGFloat = 16
        }
    }
}
