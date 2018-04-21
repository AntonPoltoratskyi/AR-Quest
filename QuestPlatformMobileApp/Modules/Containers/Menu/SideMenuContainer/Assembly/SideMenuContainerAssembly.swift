//
//  SideMenuContainerAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class SideMenuContainerAssembly: Assembly {
    
    typealias Input = Module<SideMenuContainerModuleInput>
    
    func build() -> Input {
        let view = SideMenuContainerViewController()
        let presenter = SideMenuContainerPresenter()
        let interactor = SideMenuContainerInteractor()
        let router = SideMenuContainerRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
