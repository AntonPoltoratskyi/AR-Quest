//
//  ApplicationCore.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public protocol ApplicationServiceDelegate: UIApplicationDelegate {
    var services: [ApplicationService] { get }
}

open class ApplicationCore: UIResponder, ApplicationServiceDelegate {
    
    open var services: [ApplicationService] {
        return []
    }
    private lazy var _services: [ApplicationService] = {
        return self.services
    }()
    
    
    // MARK: UIApplicationDelegate
    
    open var window: UIWindow?
    
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        _services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        guard !_services.isEmpty else { return true }
        
        return _services.reduce(false) { result, service -> Bool in
            let next = service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
            return result || next
        }
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        _services.forEach { $0.applicationWillResignActive?(application) }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        _services.forEach { $0.applicationDidEnterBackground?(application) }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        _services.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        _services.forEach { $0.applicationDidBecomeActive?(application) }
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        _services.forEach { $0.applicationWillTerminate?(application) }
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return _services.reduce(false) { result, service -> Bool in
            let next = service.application?(app, open: url, options: options) ?? false
            return result || next
        }
    }
}
