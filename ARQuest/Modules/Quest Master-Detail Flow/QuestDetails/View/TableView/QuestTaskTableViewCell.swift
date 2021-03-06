//
//  QuestTaskTableViewCell.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestTaskTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private(set) lazy var cardView: QuestCardView = {
        let cardView = QuestCardView()
        contentView.addSubview(cardView)
        return cardView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Layout.Colors.titleColor
        label.font = Layout.Fonts.titleFont
        cardView.addSubview(label)
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
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(Layout.titleLabel.horizontalInset)
            maker.trailing.equalToSuperview().inset(Layout.titleLabel.horizontalInset)
            maker.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        cardView.setHighlighted(highlighted, animated: animated)
    }
}

// MARK: - Layout

extension QuestTaskTableViewCell {
    
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
