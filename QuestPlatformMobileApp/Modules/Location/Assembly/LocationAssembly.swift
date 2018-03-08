//
//  LocationAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationAssembly: Assembly {
    
    typealias Input = Module<LocationModuleInput>
    
    func build() -> Input {
        let view = LocationViewController()
        let presenter = LocationPresenter()
        let interactor = LocationInteractor()
        let router = LocationRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
