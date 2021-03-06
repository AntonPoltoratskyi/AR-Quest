//
//  ConstructorAssembly.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorAssembly: Assembly {
    
    typealias Input = Module<ConstructorModuleInput>
    
    func build() -> Input {
        // Dependencies
        let factory = ServiceFactory.shared
        
        // Module
        let view = ConstructorViewController()
        let presenter = ConstructorPresenter()
        let interactor = ConstructorInteractor(questService: factory.makeQuestService())
        let router = ConstructorRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        router.output = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
