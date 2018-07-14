//
//  ConstructorFinishView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishView: BaseView {
    
    override var title: String? {
        return "Congratulations!"
    }
    
    override var backgroundView: UIView? {
        return QuestBackgroundView()
    }
    
    private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
        Congratulations!
        You have just created a new quest!
        """
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var doneButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Done", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        textLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview().offset(-48)
            maker.horizontalInset(16)
        }
        
        codeLabel.snp.makeConstraints { maker in
            maker.horizontalInset(16)
            maker.top.equalTo(textLabel.snp.bottom).offset(32)
        }
        
        doneButton.snp.makeConstraints { maker in
            maker.buttonHeight()
            maker.horizontalInset(16)
            maker.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setupCode(_ code: String) {
        codeLabel.text =  """
        Join by code:
        
        \(code)
        """
    }
}
