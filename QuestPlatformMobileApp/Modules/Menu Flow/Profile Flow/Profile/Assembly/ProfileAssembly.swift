//
//  ProfileAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileAssembly: Assembly {
    
    typealias Input = Module<ProfileModuleInput>
    
    func build() -> Input {
        // Dependencies
        let client = URLSessionNetworkClient()
        let userService = UserNetworkServiceStub(client: client, session: .shared)
        
        // Module
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(userService: userService)
        let router = ProfileRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return Module(input: presenter, view: view)
    }
}
