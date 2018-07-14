//
//  SplashView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class SplashView: UIView {
    
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()
    
    private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.6
        imageView.image = #imageLiteral(resourceName: "splash")
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        return imageView
    }()

    private(set) lazy var largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 52, weight: .semibold)
        label.text = """
        Welcome to
        \(Bundle.main.displayName)
        """
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 14, weight: .regular)
        label.text = "The best way to have fun and discover more emotions and places. Let's get started!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var buttonsContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        contentView.addSubview(container)
        return container
    }()
    
    private(set) lazy var buttonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 12, weight: .regular)
        label.text = "Continue with:"
        label.textAlignment = .center
        label.textColor = .white
        buttonsContainer.addSubview(label)
        return label
    }()
    
    private(set) lazy var emailButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("EMAIL", for: .normal)
        buttonsContainer.addSubview(button)
        return button
    }()
    
    private(set) lazy var facebookButton: QuestButton = {
        let button = QuestButton()
        button.backgroundColor = Theme.Button.Color.darkGray
        button.setTitle("FACEBOOK", for: .normal)
        buttonsContainer.addSubview(button)
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    
    // MARK: - UI Setup
    
    private func setupSubviews() {
        backgroundColor = Theme.Button.Color.darkGray
        
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview().offset(24)
            maker.trailing.equalToSuperview().inset(24)
            maker.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
        
        buttonsContainer.snp.makeConstraints { maker in
            maker.bottom.leading.trailing.equalToSuperview()
        }
        
        // Buttons
        
//        facebookButton.snp.makeConstraints { maker in
//            maker.bottom.leading.trailing.equalToSuperview()
//            maker.buttonHeight()
//        }
        
        emailButton.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview() //equalTo(facebookButton.snp.top).offset(-12)
            maker.buttonHeight()
        }
        
        buttonsLabel.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
            maker.bottom.equalTo(emailButton.snp.top).offset(-16)
        }
        
        // Title
        
        subtitleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(buttonsContainer.snp.top).offset(-96)
        }
        
        largeTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        largeTitleLabel.snp.makeConstraints { maker in
            maker.height.equalTo(160)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(subtitleLabel.snp.top).offset(-32)
        }
    }
}
