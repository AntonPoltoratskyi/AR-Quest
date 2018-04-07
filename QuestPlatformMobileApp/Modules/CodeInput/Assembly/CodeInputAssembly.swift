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
        let view = CodeInputViewController()
        let presenter = CodeInputPresenter()
        let interactor = CodeInputInteractor()
        let router = CodeInputRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.questNetworkService = QuestNetworkServiceStub(networkClient: URLSessionNetworkClient())
        
        return Module(input: presenter, view: view)
    }
}
