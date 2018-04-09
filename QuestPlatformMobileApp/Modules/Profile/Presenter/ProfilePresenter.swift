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
    
}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    
}
