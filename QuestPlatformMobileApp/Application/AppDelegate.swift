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
    

    // MARK: - Events
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        prepare()
        setupViewHierarchy()
        return result
    }
    
    
    // MARK: - View Hierarchy
    
    private func setupViewHierarchy() {
        let splash = SplashAssembly().build()
        let navigation = NavigationAssembly(embeddedModule: splash.input)
    
        self.window?.rootViewController = navigation.build().view
        self.window?.makeKeyAndVisible()
    }
    
    
    // MARK: - Debug
    
    private func prepare() {
        // TODO: remove this stub
        let user = User(id: 1, name: "Antony", email: "test@gmail.com")
        SessionStorage.shared.setSession("token", forUser: user)
    }
}
