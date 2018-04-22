//
//  EditProfileProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol EditProfileModuleInput: ModuleInput {
}

// MARK: - View

protocol EditProfileViewInput: class {
    func setup(with user: User)
}

// MARK: -
protocol EditProfileViewOutput: class {
    func viewDidLoad()
    func didClickSave(userInfo: EditUserInfo)
}

// MARK: - Interactor

protocol EditProfileInteractorInput: class {
    func fetchUserInfo()
    func editUser(_ user: User)
}

// MARK: -
protocol EditProfileInteractorOutput: class {
    func didFetchUser(_ user: User)
    func didEditUser(_ user: User)
    func didReceiveFailure(_ error: Error)
}

// MARK: - Router

protocol EditProfileRouterInput: class {
    func finish()
}
