//
//  CodeInputAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputAssembly: Assembly {
    
    typealias Input = Module<CodeInputModuleInput>
    
    func build() -> Input {
        // Dependencies
        let client = URLSessionNetworkClient()
        let questService = QuestNetworkServiceStub(client: client, session: .shared)
        
        // Module
        let view = CodeInputViewController()
        let presenter = CodeInputPresenter()
        let interactor = CodeInputInteractor(questNetworkService: questService)
        let router = CodeInputRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
