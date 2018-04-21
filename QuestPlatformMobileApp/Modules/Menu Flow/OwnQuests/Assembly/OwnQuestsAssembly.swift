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
        let view = OwnQuestsViewController()
        let presenter = OwnQuestsPresenter()
        let interactor = OwnQuestsInteractor()
        let router = OwnQuestsRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        interactor.questNetworkService = QuestNetworkServiceStub(networkClient: URLSessionNetworkClient())
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
