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
    
    func didClickLogin(email: String?, password: String?) {
        do {
            let validEmail = try EmailValidator().validated(email)
            let validPassword = try PasswordValidator().validated(password)
            
            let credentials = LoginCredentials(email: validEmail, password: validPassword)
            interactor.login(with: credentials)
        } catch {
            if let error = error as? ErrorRepresentable {
                view.showError(error.errorMessage)
            }
        }
    }
}

// MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {
    
    func didLogin(user: User) {
        
    }
    
    func didRegister(user: User) {
        
    }
    
    func didFailure(_ error: Error) {
        if let error = error as? ErrorRepresentable {
            view.showError(error.errorMessage)
        }
    }
}
