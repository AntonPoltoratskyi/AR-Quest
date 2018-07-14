//
//  EditProfilePresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class EditProfilePresenter: Presenter, EditProfileModuleInput {
    
    typealias View = EditProfileViewInput
    typealias Interactor = EditProfileInteractorInput
    typealias Router = EditProfileRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    private var user: User?
}

// MARK: - EditProfileViewOutput
extension EditProfilePresenter: EditProfileViewOutput {
    
    func didClickSave(userInfo: EditUserInfo) {
        guard let user = user else { return }
        // TODO: validate username
        user.name = userInfo.username
        interactor.editUser(user)
    }
}

// MARK: - EditProfileInteractorOutput
extension EditProfilePresenter: EditProfileInteractorOutput {

    func viewDidLoad() {
        interactor.fetchUserInfo()
    }
    
    func didFetchUser(_ user: User) {
        self.user = user
        view.setup(with: user)
    }
    
    func didEditUser(_ user: User) {
        self.user = user
        view.setup(with: user)
        router.finish()
    }
    
    func didReceiveFailure(_ error: Error) {
        
    }
}
