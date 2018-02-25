//
//  NavigationAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class NavigationAssembly: Assembly {
    
    typealias Input = Module<NavigationModuleInput>
    
    private let embeddedModule: ModuleInput
    
    init(embeddedModule: ModuleInput) {
        self.embeddedModule = embeddedModule
    }
    
    func build() -> Input {
        let view = NavigationViewController(rootViewController: embeddedModule.viewController!)
        let presenter = NavigationPresenter()
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
