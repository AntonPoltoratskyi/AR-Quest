//
//  Application.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public protocol ApplicationServiceDelegate: UIApplicationDelegate {
    var services: [ApplicationService] { get }
}

open class Application: UIResponder, ApplicationServiceDelegate {

    public private(set) lazy var services: [ApplicationService] = {
        return []
    }()
    
    
    // MARK: UIApplicationDelegate
    
    open var window: UIWindow? = UIWindow()
    
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        guard !services.isEmpty else { return true }
        
        return services.reduce(false) { result, service -> Bool in
            let next = service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
            return result || next
        }
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        services.forEach { $0.applicationWillResignActive?(application) }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        services.forEach { $0.applicationDidEnterBackground?(application) }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        services.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        services.forEach { $0.applicationDidBecomeActive?(application) }
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        services.forEach { $0.applicationWillTerminate?(application) }
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return services.reduce(false) { result, service -> Bool in
            let next = service.application?(app, open: url, options: options) ?? false
            return result || next
        }
    }
}
