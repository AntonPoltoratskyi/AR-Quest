//
//  ConstructorFinishViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishViewController: UIViewController, View {
    
    typealias Output = ConstructorFinishViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: ConstructorFinishView = {
        let contentView = ConstructorFinishView()
        contentView.doneButton.addTarget(self, action: #selector(actionDoneButtonTapped(sender:)), for: .touchUpInside)
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @objc private func actionDoneButtonTapped(sender: UIButton) {
        output.didTapDoneButton()
    }
}

// MARK: - ConstructorFinishViewInput
extension ConstructorFinishViewController: ConstructorFinishViewInput {
    
    func setupCode(_ code: String) {
        contentView.setupCode(code)
    }
}
