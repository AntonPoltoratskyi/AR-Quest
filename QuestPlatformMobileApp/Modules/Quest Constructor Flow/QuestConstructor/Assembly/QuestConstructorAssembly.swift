//
//  QuestConstructorAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestConstructorAssembly: Assembly {
    
    typealias Input = Module<QuestConstructorModuleInput>
    
    func build() -> Input {
        let view = QuestConstructorViewController()
        let presenter = QuestConstructorPresenter()
        let interactor = QuestConstructorInteractor()
        let router = QuestConstructorRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
