//
//  SplashViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol SplashViewInput: class {
}

protocol SplashViewOutput: class {
    func didFinishSplashAnimation()
}

final class SplashViewController: UIViewController, View {
    typealias Output = SplashViewOutput
    var output: Output!
    
    
    // MARK: - Views

    private lazy var contentView: SplashView = {
        let contentView = SplashView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.output.didFinishSplashAnimation()
        }
    }
}

extension SplashViewController: SplashViewInput {
    
}
