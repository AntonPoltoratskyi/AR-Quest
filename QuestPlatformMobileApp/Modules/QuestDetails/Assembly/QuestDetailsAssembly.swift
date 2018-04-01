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
        
        return Module(input: presenter, view: view)
    }
}
