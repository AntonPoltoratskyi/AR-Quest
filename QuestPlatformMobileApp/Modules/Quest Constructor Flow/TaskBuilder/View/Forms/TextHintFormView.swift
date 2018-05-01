//
//  TextHintFormView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class TextHintFormView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = Theme.NavigationView.Color.backgroundColor.cgColor
        textView.layer.borderWidth = 0.5
        addSubview(textView)
        return textView
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
        
        textView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
