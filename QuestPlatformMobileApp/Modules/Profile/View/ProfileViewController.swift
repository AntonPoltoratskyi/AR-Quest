//
//  ProfileViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, View {
    
    typealias Output = ProfileViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: ProfileView = {
        let contentView = ProfileView()
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

// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    
}
