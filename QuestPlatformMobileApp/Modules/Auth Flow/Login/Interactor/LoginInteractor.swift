//
//  LoginInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol LoginInteractorInput: class {
    func login(with credentials: LoginCredentials)
    func register(with credentials: SignUpCredentials)
}

protocol LoginInteractorOutput: LoadingRepresentable {
    func didLogin(user: User)
    func didRegister(user: User)
    func didFailure(_ error: Error)
}

final class LoginInteractor: Interactor, LoginInteractorInput {
    typealias Output = LoginInteractorOutput
    weak var output: LoginInteractorOutput!
    
    // MARK: - Dependencies
    
    private let authService: AuthNetworkService
    
    
    // MARK: - Init
    
    init(authService: AuthNetworkService) {
        self.authService = authService
    }
    
    
    // MARK: - Actions
    
    func login(with credentials: LoginCredentials) {
        output.didStartLoading()
        authService.login(with: credentials) { [weak self] result in
            defer { self?.output?.didFinishLoading() }
            switch result {
            case let .success(user):
                self?.output.didLogin(user: user)
            case let .failure(error):
                self?.output.didFailure(error)
            }
        }
    }
    
    func register(with credentials: SignUpCredentials) {
        output.didStartLoading()
        authService.register(with: credentials) { [weak self] result in
            defer { self?.output?.didFinishLoading() }
            switch result {
            case let .success(user):
                self?.output.didRegister(user: user)
            case let .failure(error):
                self?.output.didFailure(error)
            }
        }
    }
}
