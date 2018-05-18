//
//  AboutView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class AboutView: BaseView {
    
    override var title: String? {
        return "About"
    }
   
    override var backgroundView: UIView {
        return QuestBackgroundView()
    }
    
    
    // MARK: - Views
    
    private(set) lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_launcher")
        imageView.backgroundColor = .lightGray
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = Bundle.main.displayName
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "The best way to have fun and discover more emotions and places. Let's get started!"
        label.contentMode = .left
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "(c) \(Calendar.current.component(.year, from: Date())) \(Bundle.main.displayName)"
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview(label)
        return label
    }()

    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        appIconImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Layout.appIcon.top)
            maker.left.equalToSuperview().offset(Layout.appIcon.left)
            maker.width.height.equalTo(Layout.appIcon.size)
        }
        appNameLabel.snp.makeConstraints { maker in
            maker.left.equalTo(appIconImageView.snp.right).offset(Layout.appName.horizontalInset)
            maker.right.equalToSuperview().inset(Layout.appName.horizontalInset)
            maker.centerY.equalTo(appIconImageView)
        }
        appDescriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(appIconImageView.snp.bottom).offset(Layout.appDescription.top)
            maker.horizontalInset(Layout.appDescription.horizontalInset)
            maker.bottom.lessThanOrEqualTo(copyrightLabel.snp.top).offset(-Layout.appDescription.bottom)
        }
        copyrightLabel.snp.makeConstraints { maker in
            maker.horizontalInset(Layout.copyright.horizontalInset)
            maker.bottom.equalToSuperview().inset(Layout.copyright.bottom)
            maker.centerX.equalToSuperview()
        }
    }
}

// MARK: - Layout

extension AboutView {
    
    enum Layout {
        
        enum appIcon {
            static let size: CGFloat = 44
            static let top: CGFloat = 16
            static let left: CGFloat = 16
        }
        
        enum appName {
            static let horizontalInset: CGFloat = 16
        }
        
        enum appDescription {
            static let horizontalInset: CGFloat = 16
            static let top: CGFloat = 16
            static let bottom: CGFloat = 16
        }
        
        enum copyright {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 16
        }
    }
}
