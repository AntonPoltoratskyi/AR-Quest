//
//  QuestInfoPopupViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestInfoPopupViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = QuestInfoPopupViewOutput
    var output: Output!
    
    private var selectedAccessLevel: Quest.AccessLevel = .public
    
    
    // MARK: - Views
    
    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
    var keyboardInputViews: [KeyboardInputView] {
        return [contentView.titleField]
    }
    
    private lazy var contentView: QuestInfoPopupView = {
        let contentView = QuestInfoPopupView()
        contentView.saveButton.addTarget(self, action: #selector(actionSaveButtonTapped(sender:)), for: .touchUpInside)
        contentView.accessLevelSelectionHandler = { [weak self] accessLevel in
            self?.selectedAccessLevel = accessLevel
        }
        contentView.titleField.delegate = self
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
    
    @objc private func actionSaveButtonTapped(sender: UIButton) {
        let title = contentView.titleField.text
        output.didTapSave(title: title, accessLevel: selectedAccessLevel)
    }
}

// MARK: - QuestInfoPopupViewInput
extension QuestInfoPopupViewController: QuestInfoPopupViewInput {
    
}

// MARK: - UITextFieldDelegate
extension QuestInfoPopupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleNextInput(textField)
        return true
    }
}
