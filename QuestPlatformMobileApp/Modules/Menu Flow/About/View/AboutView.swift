//
//  AboutView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class AboutView: UIView {
    
    // MARK: - Views
   
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        addSubview(backgroundView)
        return backgroundView
    }()
    
    private(set) lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: set app icon image
        addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "QUEST App"
        addSubview(label)
        return label
    }()
    
    private(set) lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "(c) \(Calendar.current.component(.year, from: Date()))"
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
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        appIconImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Layout.appIcon.top)
            maker.left.equalToSuperview().offset(Layout.appIcon.left)
            maker.width.height.equalTo(Layout.appIcon.size)
        }
        appNameLabel.snp.makeConstraints { maker in
            maker.left.equalTo(appIconImageView.snp.right).offset(Layout.appName.horizontalInset)
            maker.left.equalToSuperview().inset(Layout.appName.horizontalInset)
            maker.centerY.equalTo(appIconImageView)
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
        
        enum copyright {
            static let horizontalInset: CGFloat = 16
            static let bottom: CGFloat = 16
        }
    }
}
