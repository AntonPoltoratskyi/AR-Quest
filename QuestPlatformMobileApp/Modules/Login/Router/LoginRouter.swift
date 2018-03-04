//
//  LoginRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LoginRouterInput: class {
    func showContent()
}

final class LoginRouter: Router, LoginRouterInput {
    
    weak var viewController: UIViewController!
    
    func showContent() {
        let menuContainer = SideMenuContainerAssembly().build()
        let leftMenu = MenuAssembly().build()
        
        menuContainer.input.setupCenter(leftMenu.view)
        
        viewController.present(menuContainer.view, animated: true, completion: nil)
    }
}
