//
//  QuestAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestAssembly: Assembly {
    
    typealias Input = Module<QuestModuleInput>
    
    func build() -> Input {
        // Module
        let view = QuestViewController()
        let presenter = LiveQuestPresenter(destination: .debugCoordinate)
        let interactor = QuestInteractor(locationService: .shared)
        let router = QuestRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
