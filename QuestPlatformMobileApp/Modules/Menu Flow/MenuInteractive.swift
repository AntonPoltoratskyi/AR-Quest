//
//  MenuInteractive.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import LGSideMenuController

protocol MenuInteractive: class {
    func showMenu()
    func hideMenu()
    func toggleMenu()
}

// MARK: - View
extension MenuInteractive where Self: View, Self.Output: MenuInteractive {
    
    func showMenu() {
        output.showMenu()
    }
    
    func hideMenu() {
        output.hideMenu()
    }
    
    func toggleMenu() {
        output.toggleMenu()
    }
}

// MARK: - Presenter
extension MenuInteractive where Self: Presenter, Self.Router: MenuInteractive {
    
    func showMenu() {
        router.showMenu()
    }
    
    func hideMenu() {
        router.hideMenu()
    }
    
    func toggleMenu() {
        router.toggleMenu()
    }
}

// MARK: - Router
extension MenuInteractive where Self: Router {
    
    func showMenu() {
        viewController?.showLeftViewAnimated(nil)
    }
    
    func hideMenu() {
        viewController?.hideLeftViewAnimated(nil)
    }
    
    func toggleMenu() {
        viewController?.toggleLeftViewAnimated(nil)
    }
}
