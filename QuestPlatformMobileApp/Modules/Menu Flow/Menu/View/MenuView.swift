//
//  MenuView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var navigationView: QuestNavigationView = {
        let navigationView = QuestNavigationView()
        addSubview(navigationView)
        return navigationView
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
        
        navigationView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview()
        }
    }
}
