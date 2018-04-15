//
//  MainAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MainAssembly: Assembly {
    
    typealias Input = Module<MainModuleInput>
    
    func build() -> Input {
        let view = MainViewController()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
