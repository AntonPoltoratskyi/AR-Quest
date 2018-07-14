//
//  SplashPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Module Input

protocol SplashModuleInput: ModuleInput {
}

// MARK: - Presenter

final class SplashPresenter: SplashModuleInput, Presenter {

    typealias View = SplashViewInput
    typealias Interactor = SplashInteractorInput
    typealias Router = SplashRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - SplashViewOutput
extension SplashPresenter: SplashViewOutput {
    
    func loginWithEmail() {
        router.presentLogin()
    }
    
    func loginWithFacebook() {
        
    }
}

// MARK: - SplashInteractorOutput
extension SplashPresenter: SplashInteractorOutput {
    
}
