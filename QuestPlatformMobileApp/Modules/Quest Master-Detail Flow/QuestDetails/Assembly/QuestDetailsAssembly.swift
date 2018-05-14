//
//  QuestDetailsAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestDetailsAssembly: Assembly {
    
    typealias Input = Module<QuestDetailsModuleInput>
    
    private let quest: Quest

    init(quest: Quest) {
        self.quest = quest
    }
    
    func build() -> Input {
        // Dependencies
        let factory = ServiceFactory.shared
        
        // Module
        let view = QuestDetailsViewController()
        let presenter = QuestDetailsPresenter()
        let interactor = QuestDetailsInteractor(questNetworkService: factory.makeQuestService())
        let router = QuestDetailsRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.quest = quest
        
        return Module(input: presenter, view: view)
    }
}
