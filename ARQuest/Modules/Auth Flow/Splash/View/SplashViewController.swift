//
//  SplashViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol SplashViewInput: class {
}

protocol SplashViewOutput: class {
    func loginWithEmail()
    func loginWithFacebook()
}

final class SplashViewController: UIViewController, View {
    typealias Output = SplashViewOutput
    var output: Output!
    
    
    // MARK: - Views

    private lazy var contentView: SplashView = {
        let contentView = SplashView()
        contentView.emailButton.addTarget(self, action: #selector(actionLoginWithEmail(_:)), for: .touchUpInside)
        contentView.facebookButton.addTarget(self, action: #selector(actionLoginWithFacebook(_:)), for: .touchUpInside)
        return contentView
    }()
    
    private var buttons: [UIButton] {
        return [contentView.emailButton, contentView.facebookButton]
    }
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        contentView.buttonsContainer.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.7, animations: {
            self.contentView.buttonsContainer.alpha = 1
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        enableButtons(true)
    }
    
    
    // MARK: - UI Setup
    
    private func setupUI() {
    }
    
    
    // MARK: - Actions
    
    private func enableButtons(_ isEnabled: Bool) {
        buttons.forEach { $0.isEnabled = isEnabled }
    }
    
    @objc private func actionLoginWithEmail(_ sender: UIButton) {
        enableButtons(false)
        output.loginWithEmail()
    }
    
    @objc private func actionLoginWithFacebook(_ sender: UIButton) {
        enableButtons(false)
        output.loginWithFacebook()
    }
}

extension SplashViewController: SplashViewInput {
    
}
