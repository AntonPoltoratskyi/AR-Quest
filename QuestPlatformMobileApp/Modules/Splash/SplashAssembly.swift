//
//  SplashAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class SplashAssembly: Assembly {
    
    typealias ModuleInput = SplashModuleInput

    static func build() -> SplashModuleInput {
        let view = SplashViewController()
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return presenter
    }
}
