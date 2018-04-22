//
//  ProfilePresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfilePresenter: Presenter, ProfileModuleInput {
    
    typealias View = ProfileViewInput
    typealias Interactor = ProfileInteractorInput
    typealias Router = ProfileRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
 
    private var user: User!
}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    
    func viewWillAppear() {
        interactor.fetchUserInfo()
    }
    
    func didClickCreate() {
        router.showConstructor()
    }
    
    func didClickEdit() {
        router.showEditProfile()
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    
    func didFetchUser(_ user: User) {
        self.user = user
        view.setupUser(user)
    }
    
    func didReceiveFailure(_ error: Error) {
        
    }
}
