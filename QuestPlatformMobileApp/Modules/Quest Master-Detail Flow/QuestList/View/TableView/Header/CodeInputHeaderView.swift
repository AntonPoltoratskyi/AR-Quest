//
//  CodeInputHeaderView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class CodeInputHeaderView: UITableViewHeaderFooterView, Reusable {
    
    // MARK: - Views
    
    private(set) lazy var joinButton: QuestButton = {
        let joinButton = QuestButton()
        joinButton.setTitle("Join by code", for: .normal)
        contentView.addSubview(joinButton)
        return joinButton
    }()
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        let background = UIView()
        background.backgroundColor = .clear
        backgroundView = background
        
        joinButton.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(Layout.joinButton.insets)
            maker.height.equalTo(Layout.joinButton.height)
        }
    }
}

// MARK: - Layout

extension CodeInputHeaderView {
    
    enum Layout {
        static let height: CGFloat = joinButton.insets.vertical + joinButton.height
        
        enum joinButton {
            static let height: CGFloat = 44
            static let insets = UIEdgeInsets(top: 8, left: 32, bottom: 8, right: 32)
        }
    }
}
