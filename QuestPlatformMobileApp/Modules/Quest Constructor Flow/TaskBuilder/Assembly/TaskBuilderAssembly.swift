//
//  TaskBuilderAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderAssembly: Assembly {
    
    typealias Input = Module<TaskBuilderModuleInput>
    
    func build() -> Input {
        let view = TaskBuilderViewController()
        let presenter = TaskBuilderPresenter()
        let interactor = TaskBuilderInteractor()
        let router = TaskBuilderRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
