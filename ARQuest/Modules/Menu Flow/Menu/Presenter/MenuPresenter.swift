//
//  MenuPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuPresenter: Presenter, MenuModuleInput {
    
    typealias View = MenuViewInput
    typealias Interactor = MenuInteractorInput
    typealias Router = MenuRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - MenuViewOutput
extension MenuPresenter: MenuViewOutput {
    
    func showProfile() {
        router.showProfile()
    }
    
    func showPublicQuests() {
        router.showPublicQuests()
    }
    
    func showMyQuests() {
        router.showMyQuests()
    }
    
    func startNewQuest() {
        router.startNewQuest()
    }
    
    func showAbout() {
        router.showAbout()
    }
    
    func logout() {
        interactor.logout()
    }
}

// MARK: - MenuInteractorOutput
extension MenuPresenter: MenuInteractorOutput {
    
    func didLogout() {
        router.performLogout()
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
