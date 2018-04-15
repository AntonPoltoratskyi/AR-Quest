//
//  ConstructorFinishAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishAssembly: Assembly {
    
    typealias Input = Module<ConstructorFinishModuleInput>
    
    func build() -> Input {
        let view = ConstructorFinishViewController()
        let presenter = ConstructorFinishPresenter()
        let interactor = ConstructorFinishInteractor()
        let router = ConstructorFinishRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
