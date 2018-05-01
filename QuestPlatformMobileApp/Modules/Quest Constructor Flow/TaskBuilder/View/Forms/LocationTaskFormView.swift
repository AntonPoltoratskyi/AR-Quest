//
//  LocationTaskFormView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationTaskFormView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var selectButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Select Destination", for: .normal)
        addSubview(button)
        return button
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = Theme.NavigationView.Color.backgroundColor.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        return imageView
    }()
    
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        imageView.addSubview(activityIndicator)
        return activityIndicator
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
        
        selectButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.horizontalInset(16)
            maker.buttonHeight()
        }
        
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(selectButton.snp.bottom).offset(16)
            maker.horizontalInset(0)
            maker.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setupLocationImage(_ image: UIImage) {
        imageView.image = image
    }
}
