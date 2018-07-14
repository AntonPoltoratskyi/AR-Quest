//
//  MenuItemTableViewCell.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class MenuItemTableViewCell: UITableViewCell {
   
    var title: String? {
        didSet { menuTextLabel.text = title }
    }
    
    // MARK: - Views
    
    private lazy var menuTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 17, weight: .medium)
        label.textColor = .darkText
        addSubview(label)
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
        selectionStyle = .none
        backgroundColor = .clear
        
        menuTextLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.horizontalInset(16)
        }
    }
}
