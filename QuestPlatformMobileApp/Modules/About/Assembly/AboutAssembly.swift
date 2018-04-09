//
//  AboutAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class AboutAssembly: Assembly {
    
    typealias Input = Module<AboutModuleInput>
    
    func build() -> Input {
        let view = AboutViewController()
        let presenter = AboutPresenter()
        let interactor = AboutInteractor()
        let router = AboutRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
