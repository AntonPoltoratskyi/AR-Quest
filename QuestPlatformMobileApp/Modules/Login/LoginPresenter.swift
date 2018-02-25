//
//  LoginPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol LoginModuleInput: ModuleInput {
}

// MARK: - Presenter

final class LoginPresenter: Presenter, LoginModuleInput {
    
    typealias View = LoginViewInput
    typealias Interactor = LoginInteractorInput
    typealias Router = LoginRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}


// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    
}

// MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {
    
}
