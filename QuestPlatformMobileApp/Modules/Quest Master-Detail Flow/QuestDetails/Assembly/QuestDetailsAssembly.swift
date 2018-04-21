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
        let view = QuestDetailsViewController()
        let presenter = QuestDetailsPresenter()
        let interactor = QuestDetailsInteractor()
        let router = QuestDetailsRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.quest = quest
        interactor.questNetworkService = QuestNetworkServiceStub(client: URLSessionNetworkClient())
        
        return Module(input: presenter, view: view)
    }
}
