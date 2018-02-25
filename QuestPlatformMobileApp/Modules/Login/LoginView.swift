//
//  LoginView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Login"
        self.addSubview(label)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    
    // MARK: - UI Setup
    
    private func setupSubviews() {
        backgroundColor = .white
        label.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
}
