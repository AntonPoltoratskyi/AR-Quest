//
//  AppDelegate.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.11.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: AppDelegateProxy {
    
    public override lazy var services: [ApplicationService] = {
        return []
    }()
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        setupViewHierarchy()
        return true
    }
    
    private func setupViewHierarchy() {
        let splash = SplashAssembly().build()
        let navigation = NavigationAssembly(embeddedModule: splash.input)
    
        self.window?.rootViewController = navigation.build().view
        self.window?.makeKeyAndVisible()
    }
}

