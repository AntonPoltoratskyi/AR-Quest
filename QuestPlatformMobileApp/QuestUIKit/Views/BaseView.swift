//
//  BaseView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class BaseView: UIView {

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
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        addSubview(contentView)
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
            contentView.snp.makeConstraints { maker in
                maker.bottom.left.right.equalToSuperview()
                maker.top.equalTo(navigationView.snp.bottom)
            }
        } else {
            contentView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
        }
    }
}
