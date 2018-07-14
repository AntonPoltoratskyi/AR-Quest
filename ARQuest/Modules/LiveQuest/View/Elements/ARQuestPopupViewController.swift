//
//  ARQuestPopupViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.06.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

class ARQuestPopupViewController: UIViewController {

    var closeHandler: ((ARQuestPopupViewController) -> Void)?
    
    var text: String?
    
    
    // MARK: - Views
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        view.addSubview(contentView)
        
        return contentView
    }()
    
    private(set) lazy var closeButton: QuestButton = {
        let button = QuestButton()
        button.addTarget(self, action: #selector(handleClose(sender:)), for: .touchUpInside)
        button.setTitle("OK", for: .normal)
        view.addSubview(button)
        return button
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(label)
        return label
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        label.text = text
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        contentView.snp.makeConstraints { maker in
            maker.bottom.equalTo(closeButton.snp.top).offset(-12)
            maker.horizontalInset(16)
            maker.height.greaterThanOrEqualTo(280)
        }
        
        label.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(12)
            maker.top.greaterThanOrEqualToSuperview().offset(8)
            maker.bottom.lessThanOrEqualToSuperview().offset(-8)
            maker.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { maker in
            maker.horizontalInset(16)
            maker.bottom.equalToSuperview().offset(-16)
            maker.buttonHeight()
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func handleClose(sender: Any) {
        closeHandler?(self)
    }
}
