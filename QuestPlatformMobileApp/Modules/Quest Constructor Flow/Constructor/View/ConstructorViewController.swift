//
//  ConstructorViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorViewController: UIViewController, View {
    
    typealias Output = ConstructorViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: ConstructorView = {
        let contentView = ConstructorView()
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

// MARK: - ConstructorViewInput
extension ConstructorViewController: ConstructorViewInput {
    
}
