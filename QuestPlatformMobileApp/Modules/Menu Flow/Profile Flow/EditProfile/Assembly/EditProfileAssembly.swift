//
//  EditProfileAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class EditProfileAssembly: Assembly {
    
    typealias Input = Module<EditProfileModuleInput>
    
    func build() -> Input {
        // Dependencies
        let client = URLSessionNetworkClient()
        let userService = UserNetworkServiceStub(client: client, session: .shared)
        
        // Module
        let view = EditProfileViewController()
        let presenter = EditProfilePresenter()
        let interactor = EditProfileInteractor(userService: userService)
        let router = EditProfileRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
