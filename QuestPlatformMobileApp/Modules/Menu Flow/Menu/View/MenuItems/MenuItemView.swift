//
//  MenuItemView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class MenuItemView: UIView {
    
    var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    
    var selectionHandler: ((MenuItemView) -> Void)?
    
    
    // MARK: - Views
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.appFont(ofSize: 17, weight: .regular)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped(sender:)), for: .touchUpInside)
        addSubview(button)
        return button
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
        button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func actionButtonTapped(sender: UIButton) {
        selectionHandler?(self)
    }
}
