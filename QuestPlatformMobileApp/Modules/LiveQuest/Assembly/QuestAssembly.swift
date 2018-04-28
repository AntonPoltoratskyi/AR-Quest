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
        let view = QuestViewController()
        let presenter = QuestPresenter()
        let interactor = QuestInteractor()
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
