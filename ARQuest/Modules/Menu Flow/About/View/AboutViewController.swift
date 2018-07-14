//
//  AboutViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController, View {
    
    typealias Output = AboutViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: AboutView = {
        let contentView = AboutView()
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

// MARK: - AboutViewInput
extension AboutViewController: AboutViewInput {
    
}
