//
//  QuestDetailsView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestDetailsView: UIView {
    
    // MARK: - Views
    
    // MARK: Base
    
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        addSubview(backgroundView)
        return backgroundView
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        return scrollView
    }()
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        scrollView.addSubview(contentView)
        return contentView
    }()
    
    // MARK: Details
    
    private(set) lazy var topContainerView: UIView = {
        let containerView = UIView()
        contentView.addSubview(containerView)
        return containerView
    }()
    
    private(set) lazy var topHeaderView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = Theme.Header.Color.background
        contentView.addSubview(headerView)
        return headerView
    }()
    
    private(set) lazy var questNameLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Header.Font.default
        topHeaderView.addSubview(label)
        return label
    }()
    
    private(set) lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = Theme.Header.Separator.background
        topHeaderView.addSubview(separatorView)
        return separatorView
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        contentView.addSubview(tableView)
        return tableView
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
        }
        
        let minHeaderHeight = Layout.topHeaderView.minHeight
        
        topContainerView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview()
            maker.height.equalTo(minHeaderHeight)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.top.equalTo(topContainerView.snp.bottom)
            // Must be updates after reload.
            maker.height.equalTo(0)
        }
        
        topHeaderView.snp.makeConstraints { maker in
            maker.top.equalTo(self.snp.top)
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(topContainerView.snp.bottom).priority(.high)
            maker.height.greaterThanOrEqualTo(minHeaderHeight)
        }
        
        let horizontal = Layout.questNameLabel.horizontalInset
        questNameLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(Layout.questNameLabel.bottom)
            maker.left.equalToSuperview().offset(horizontal)
            maker.right.equalToSuperview().inset(horizontal)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.bottom.left.right.equalToSuperview()
            maker.height.equalTo(Layout.separatorView.height)
        }
    }
}

// MARK: - Layout

extension QuestDetailsView {
    
    enum Layout {
        enum topHeaderView {
            static let minHeight: CGFloat = 100
        }
        
        enum questNameLabel {
            static let bottom: CGFloat = 8
            static let horizontalInset: CGFloat = 16
        }
        
        enum separatorView {
            static let height: CGFloat = 1.0 / UIScreen.main.scale
        }
    }
}
