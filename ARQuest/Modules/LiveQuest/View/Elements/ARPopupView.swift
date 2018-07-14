//
//  ARPopupView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.06.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class ARPopupView: UIView {
    
    var closeHandler: (() -> Void)?
    
    // MARK: - Views
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.backgroundColor = .white
        addSubview(contentView)
        
        return contentView
    }()
    
    private(set) lazy var closeButton: QuestButton = {
        let button = QuestButton()
        button.addTarget(self, action: #selector(handleClose(sender:)), for: .touchUpInside)
        button.setTitle("OK", for: .normal)
        addSubview(button)
        return button
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
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
        contentView.snp.makeConstraints { maker in
            maker.bottom.equalTo(closeButton.snp.top).offset(-12)
            maker.horizontalInset(24)
            maker.height.greaterThanOrEqualTo(240)
        }
        
        label.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(12)
            maker.top.greaterThanOrEqualToSuperview().offset(8)
            maker.bottom.lessThanOrEqualToSuperview().offset(-8)
            maker.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { maker in
            maker.horizontalInset(24)
            maker.bottom.equalToSuperview().offset(-16)
            maker.buttonHeight()
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func handleClose(sender: Any) {
        closeHandler?()
    }
}
