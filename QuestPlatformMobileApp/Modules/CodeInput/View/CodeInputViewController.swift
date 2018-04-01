//
//  CodeInputViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputViewController: UIViewController, View {
    
    typealias Output = CodeInputViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: CodeInputView = {
        let contentView = CodeInputView()
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

// MARK: - CodeInputViewInput
extension CodeInputViewController: CodeInputViewInput {
    
}
