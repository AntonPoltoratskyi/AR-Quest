//
//  CodeInputViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = CodeInputViewOutput
    var output: Output!

    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
    var keyboardInputViews: [KeyboardInputView] {
        return [contentView.inputTextField]
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: CodeInputView = {
        let contentView = CodeInputView()
        contentView.joinButton.addTarget(self, action: #selector(actionJoinTapped(sender:)), for: .touchUpInside)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionJoinTapped(sender: UIButton) {
        let code = contentView.inputTextField.text
        output.didClickJoin(to: code)
    }
}

// MARK: - CodeInputViewInput
extension CodeInputViewController: CodeInputViewInput {
    
    func showError(_ errorMessage: String) {
        contentView.errorLabel.text = "*\(errorMessage)"
    }
}
