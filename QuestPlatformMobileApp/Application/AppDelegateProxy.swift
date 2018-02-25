//
//  AppDelegateProxy.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public protocol ApplicationService: UIApplicationDelegate { }

public class AppDelegateProxy: UIResponder, UIApplicationDelegate {

    // MARK: Services
    
    public lazy var services: [ApplicationService] = {
        return []
    }()
    
    
    // MARK: UIApplicationDelegate
    
    public var window: UIWindow? = UIWindow()
    
    public func applicationDidFinishLaunching(_ application: UIApplication) {
        services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        guard !services.isEmpty else { return true }
        
        return services.reduce(false) { result, service -> Bool in
            let next = service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
            return result || next
        }
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        services.forEach { $0.applicationWillResignActive?(application) }
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        services.forEach { $0.applicationDidEnterBackground?(application) }
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        services.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        services.forEach { $0.applicationDidBecomeActive?(application) }
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        services.forEach { $0.applicationWillTerminate?(application) }
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return services.reduce(false) { result, service -> Bool in
            let next = service.application?(app, open: url, options: options) ?? false
            return result || next
        }
    }
}
