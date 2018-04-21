//
//  MenuAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuAssembly: Assembly {
    
    typealias Input = Module<MenuModuleInput>
    
    func build() -> Input {
        // Dependencies
        let client = URLSessionNetworkClient()
        let authService = AuthNetworkServiceStub(client: client)
        
        // Module
        let view = MenuViewController()
        let presenter = MenuPresenter()
        let interactor = MenuInteractor(authService: authService)
        let router = MenuRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
