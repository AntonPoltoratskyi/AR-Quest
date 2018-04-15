//
//  QuestNavigationView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestNavigationView: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var leftButtonHandler: ((UIButton) -> Void)?
    private var rightButtonHandler: ((UIButton) -> Void)?
    
    
    // MARK: - Views
    
    /// Attached to the superview.
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Theme.NavigationView.Color.backgroundColor
        addSubview(contentView)
        return contentView
    }()
    
    /// Attached to the safe area.
    private(set) lazy var navigationView: UIView = {
        let navigationView = UIView()
        navigationView.backgroundColor = .clear
        contentView.addSubview(navigationView)
        return navigationView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Theme.NavigationView.Font.titleFont
        titleLabel.textColor = Theme.NavigationView.Color.titleColor
        titleLabel.text = "Title"
        navigationView.addSubview(titleLabel)
        return titleLabel
    }()
    
    private(set) lazy var leftBarButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.addTarget(self, action: #selector(actionLeftButtonTapped(sender:)), for: .touchUpInside)
        button.contentEdgeInsets = Layout.buttons.contentInset
        navigationView.addSubview(button)
        return button
    }()
    
    private(set) lazy var rightBarButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.addTarget(self, action: #selector(actionRightButtonTapped(sender:)), for: .touchUpInside)
        button.contentEdgeInsets = Layout.buttons.contentInset
        navigationView.addSubview(button)
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
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.bottom.equalTo(navigationView.snp.bottom)
        }
        
        navigationView.snp.makeConstraints { maker in
            maker.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            maker.left.right.bottom.equalToSuperview()
            maker.navigationViewHeight()
        }
        
        let titleHorizontalInset = QuestNavigationView.Layout.titleLabel.horizontalInset
        titleLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.left.greaterThanOrEqualTo(leftBarButton.snp.right).offset(titleHorizontalInset)
            maker.right.lessThanOrEqualTo(rightBarButton.snp.left).inset(titleHorizontalInset)
        }
        
        let buttonInset = QuestNavigationView.Layout.buttons.inset
        
        leftBarButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(buttonInset)
            maker.centerY.equalToSuperview()
        }
        rightBarButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(buttonInset)
            maker.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: - Public Input
    
    func setupLeftButton(icon: UIImage, action: @escaping (UIButton) -> Void) {
        leftBarButton.isHidden = false
        leftBarButton.setImage(icon, for: .normal)
        leftButtonHandler = action
    }
    
    func setupLeftButton(title: String, action: @escaping (UIButton) -> Void) {
        leftBarButton.isHidden = false
        leftBarButton.setTitle(title, for: .normal)
        leftButtonHandler = action
    }
    
    func setupRightButton(icon: UIImage, action: @escaping (UIButton) -> Void) {
        rightBarButton.isHidden = false
        rightBarButton.setImage(icon, for: .normal)
        rightButtonHandler = action
    }
    
    func setupRightButton(title: String, action: @escaping (UIButton) -> Void) {
        rightBarButton.isHidden = false
        rightBarButton.setTitle(title, for: .normal)
        rightButtonHandler = action
    }
    
    
    // MARK: - Actions
    
    @objc private func actionLeftButtonTapped(sender: UIButton) {
        leftButtonHandler?(sender)
    }
    
    @objc private func actionRightButtonTapped(sender: UIButton) {
        rightButtonHandler?(sender)
    }
}

// MARK: - Layout

extension QuestNavigationView {
    
    enum Layout {
        
        enum titleLabel {
            static let horizontalInset: CGFloat = 16
        }
        
        enum buttons {
            static let inset: CGFloat = 8
            static let contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
}
