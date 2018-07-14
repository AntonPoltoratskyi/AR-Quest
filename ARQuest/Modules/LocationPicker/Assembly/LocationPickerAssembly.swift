//
//  LocationPickerAssembly.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationPickerAssembly: Assembly {
    
    typealias Input = Module<LocationPickerModuleInput>
    
    func build() -> Input {
        let view = LocationPickerViewController()
        let presenter = LocationPickerPresenter()
        let interactor = LocationPickerInteractor()
        let router = LocationPickerRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
