//
//  LoginAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LoginAssembly: Assembly {
    
    typealias Input = Module<LoginModuleInput>
    
    func build() -> Input {
        // Dependency
        let client = URLSessionNetworkClient()
        let authService = AuthNetworkServiceImpl(client: client, session: .shared)
        
        // Module
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(authService: authService)
        let router = LoginRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
