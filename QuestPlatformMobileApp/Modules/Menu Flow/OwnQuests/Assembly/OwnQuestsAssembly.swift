//
//  OwnQuestsAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class OwnQuestsAssembly: Assembly {
    
    typealias Input = Module<OwnQuestsModuleInput>
    
    func build() -> Input {
        // Dependencies
        let factory = ServiceFactory.shared
        
        // Module
        let view = OwnQuestsViewController()
        let presenter = OwnQuestsPresenter()
        let interactor = OwnQuestsInteractor(questNetworkService: factory.makeQuestService())
        let router = OwnQuestsRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
