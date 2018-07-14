//
//  NavigationViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol NavigationViewInput: class {
}

protocol NavigationViewOutput: class {
}

final class NavigationViewController: UINavigationController, View {
    
    typealias Output = NavigationViewOutput
    var output: Output!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - NavigationViewInput
extension NavigationViewController: NavigationViewInput {
    
}
