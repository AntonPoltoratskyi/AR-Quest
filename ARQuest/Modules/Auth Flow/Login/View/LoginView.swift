//
//  LoginView.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: class {
    func loginViewDidSelectSignIn(_ loginView: LoginView)
    func loginViewDidSelectSignUp(_ loginView: LoginView)
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Views
    
    private(set) lazy var segmentedControl: QuestSegmentedControl = {
        let actions: [ControlAction] = [
            ControlAction(title: "SIGN IN") { [weak self] in
                guard let sSelf = self else { return }
                sSelf.delegate?.loginViewDidSelectSignIn(sSelf)
            },
            ControlAction(title: "SIGN UP") { [weak self] in
                guard let sSelf = self else { return }
                sSelf.delegate?.loginViewDidSelectSignUp(sSelf)
            }
        ]
        let control = QuestSegmentedControl(actions: actions)
        self.addSubview(control)
        return control
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        scrollView.addSubview(contentView)
        return contentView
    }()
    
    private(set) lazy var backgroundView: QuestBackgroundView = {
        let backgroundView = QuestBackgroundView()
        contentView.addSubview(backgroundView)
        return backgroundView
    }()
    
    private(set) lazy var continueButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Continue", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    private(set) lazy var loginForm: LoginFormView = {
        let form = LoginFormView()
        contentView.addSubview(form)
        return form
    }()
    
    private(set) lazy var registrationForm: RegistrationFormView = {
        let form = RegistrationFormView()
        contentView.addSubview(form)
        return form
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
        backgroundColor = .white
        
        segmentedControl.snp.makeConstraints { maker in
            maker.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            maker.leading.trailing.equalToSuperview()
            maker.segmentedControlActionHeight()
        }
        
        scrollView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(segmentedControl.snp.bottom)
        }
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { maker in
            let horizontalOffset: CGFloat = 24
            maker.leading.equalToSuperview().offset(horizontalOffset)
            maker.trailing.equalToSuperview().inset(horizontalOffset)
            maker.bottom.equalToSuperview().inset(52)
            maker.buttonHeight()
        }
        
        loginForm.snp.makeConstraints { maker in
            maker.bottom.equalTo(continueButton.snp.top).offset(-57)
            maker.leading.trailing.equalTo(continueButton)
        }
        
        registrationForm.snp.makeConstraints { maker in
            maker.bottom.equalTo(continueButton.snp.top).offset(-57)
            maker.leading.trailing.equalTo(continueButton)
        }
        
        showLoginForm()
    }
    
    
    // MARK: - Actions
    
    func showLoginForm() {
        loginForm.isHidden = false
        registrationForm.isHidden = true
    }
    
    func showSignUpForm() {
        loginForm.isHidden = true
        registrationForm.isHidden = false
    }
}
