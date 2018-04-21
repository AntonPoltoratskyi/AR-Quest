//
//  MenuInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class MenuInteractor: Interactor, MenuInteractorInput {
    typealias Output = MenuInteractorOutput
    weak var output: MenuInteractorOutput!
    
    // MARK: - Dependencies
    
    private let authService: AuthNetworkService
    
    
    // MARK: - Init
    
    init(authService: AuthNetworkService) {
        self.authService = authService
    }
    
    
    // MARK: - Actions
    
    func logout() {
        authService.logout { [weak self] result in
            switch result {
            case .success:
                self?.output?.didLogout()
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
