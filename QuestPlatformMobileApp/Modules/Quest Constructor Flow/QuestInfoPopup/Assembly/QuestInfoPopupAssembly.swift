//
//  QuestInfoPopupAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestInfoPopupAssembly: Assembly {
    
    typealias Input = Module<QuestInfoPopupModuleInput>
    
    func build() -> Input {
        let view = QuestInfoPopupViewController()
        let presenter = QuestInfoPopupPresenter()
        let interactor = QuestInfoPopupInteractor()
        let router = QuestInfoPopupRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
