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
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        interactor.authService = AuthNetworkServiceStub(client: URLSessionNetworkClient())
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
