//
//  QuestListAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestListAssembly: Assembly {
    
    typealias Input = Module<QuestListModuleInput>
    
    func build() -> Input {
        // Dependencies
        let factory = ServiceFactory.shared
        
        // Module
        let view = QuestListViewController()
        let presenter = QuestListPresenter()
        let interactor = QuestListInteractor(questNetworkService: factory.makeQuestService())
        let router = QuestListRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
