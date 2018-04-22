//
//  ProfileProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol ProfileModuleInput: ModuleInput {
}

// MARK: - View

protocol ProfileViewInput: class {
    func setupUser(_ user: User)
}

// MARK: -
protocol ProfileViewOutput: class {
    func viewDidLoad()
    func didClickCreate()
    func didClickEdit()
}

// MARK: - Interactor

protocol ProfileInteractorInput: class {
    func fetchUserInfo()
    func editUser(_ user: User)
}

// MARK: -
protocol ProfileInteractorOutput: class {
    func didFetchUser(_ user: User)
    func didEditUser(_ user: User)
    func didReceiveFailure(_ error: Error)
}

// MARK: - Router

protocol ProfileRouterInput: class {
    func showConstructor()
}
