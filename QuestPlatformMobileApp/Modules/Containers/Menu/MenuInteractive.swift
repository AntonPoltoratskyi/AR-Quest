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
