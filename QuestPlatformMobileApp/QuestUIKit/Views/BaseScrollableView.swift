//
//  BaseScrollableView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class BaseScrollableView: UIView {
    
    // MARK: - Views
    
    var backgroundView: UIView? {
        return nil
    }
    
    var isNavigationViewVisible: Bool {
        return true
    }
    
    var title: String? {
        return nil
    }
    
    private(set) lazy var navigationView: QuestNavigationView = {
        let navigationView = QuestNavigationView()
        navigationView.title = title
        return navigationView
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        return scrollView
    }()
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        scrollView.addSubview(contentView)
        return contentView
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
    
    func setup() {
        backgroundColor = .white
        
        if let backgroundView = backgroundView {
            addSubview(backgroundView)
            backgroundView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
        }
        
        if isNavigationViewVisible {
            addSubview(navigationView)
            navigationView.snp.makeConstraints { maker in
                maker.top.left.right.equalToSuperview()
            }
            scrollView.snp.makeConstraints { maker in
                maker.left.right.bottom.equalToSuperview()
                maker.top.equalTo(navigationView.snp.bottom)
            }
        } else {
            scrollView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
        }
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
    }
}
