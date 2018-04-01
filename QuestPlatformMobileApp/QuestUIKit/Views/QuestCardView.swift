//
//  QuestCardView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class QuestCardView: UIView {
    
    var cardRadius: CGFloat = 12 {
        didSet {
            contentView.layer.cornerRadius = cardRadius
        }
    }
    
    var cardColor: UIColor = Theme.CardView.Color.backgroundColor {
        didSet {
            contentView.backgroundColor = cardColor
        }
    }
    
    var cardShadowColor: UIColor = Theme.CardView.Color.shadow {
        didSet {
            contentView.layer.shadowColor = cardShadowColor.cgColor
        }
    }
    
    var contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4) {
        didSet {
            contentView.snp.updateConstraints { maker in
                maker.edges.equalToSuperview().inset(contentInset)
            }
        }
    }
    
    // MARK: - Views
    
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
    
    private func setup() {
        backgroundColor = .clear
        
        contentView.backgroundColor = cardColor
        
        contentView.layer.shadowOpacity = 0.12
        contentView.layer.cornerRadius = cardRadius
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowColor = cardShadowColor.cgColor
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(contentInset)
        }
    }
}
