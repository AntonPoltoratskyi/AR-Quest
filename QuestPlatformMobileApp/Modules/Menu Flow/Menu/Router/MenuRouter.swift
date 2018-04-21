//
//  MenuRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuRouter: Router, MenuRouterInput {
    
    weak var viewController: UIViewController!
    
    func showProfile() {
        
    }
    
    func showMyQuests() {
        
    }
    
    func startNewQuest() {
        
    }
    
    func showAbout() {
        
    }
    
    func performLogout() {
        viewController.sideMenuController?.hideLeftView(animated: true) {
            self.viewController.dismiss(animated: true, completion: nil)
        }
    }
}
