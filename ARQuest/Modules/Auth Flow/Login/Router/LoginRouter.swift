//
//  LoginRouter.swift
//  ARQuest
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
    
    private let locationService = LocationService.shared
    
    func showContent() {
        locationService.startLocationTracking()
        
        let menuContainer = SideMenuContainerAssembly().build()
        
        let leftMenu = MenuAssembly().build()
        let mainPage = MainAssembly().build()
        
        let navigation = NavigationAssembly(embeddedModule: mainPage.input).build()
        
        menuContainer.input.setupLeft(leftMenu.view)
        menuContainer.input.setupCenter(navigation.view)
        
        viewController.present(menuContainer.view, animated: true, completion: nil)
    }
}
