//
//  QuestTableViewCell.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Layout.Colors.titleColor
        label.font = Layout.Fonts.titleFont
        contentView.addSubview(label)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(Layout.titleLabel.horizontalInset)
            maker.trailing.equalToSuperview().inset(Layout.titleLabel.horizontalInset)
            maker.centerY.equalToSuperview()
        }
    }
}

// MARK: - Layout

extension QuestTableViewCell {
    
    enum Layout {
        static let height: CGFloat = 64
        
        enum Colors {
            static let titleColor = UIColor.darkText
        }
        
        enum Fonts {
            static let titleFont = UIFont.appFont(ofSize: 16, weight: .medium)
        }
        
        enum titleLabel {
            static let horizontalInset: CGFloat = 16
        }
    }
}
