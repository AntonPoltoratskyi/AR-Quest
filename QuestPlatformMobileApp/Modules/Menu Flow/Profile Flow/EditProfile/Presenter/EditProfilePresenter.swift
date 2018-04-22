//
//  EditProfilePresenter.swift
//  QuestPlatformMobileApp
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
    
}

// MARK: - EditProfileViewOutput
extension EditProfilePresenter: EditProfileViewOutput {
    
}

// MARK: - EditProfileInteractorOutput
extension EditProfilePresenter: EditProfileInteractorOutput {
    
}
