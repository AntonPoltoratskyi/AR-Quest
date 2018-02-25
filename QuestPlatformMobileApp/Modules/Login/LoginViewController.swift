//
//  LoginViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LoginViewInput: class {
}

protocol LoginViewOutput: class {
}

final class LoginViewController: UIViewController, View {
    
    typealias Output = LoginViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: LoginView = {
        let contentView = LoginView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    
}
