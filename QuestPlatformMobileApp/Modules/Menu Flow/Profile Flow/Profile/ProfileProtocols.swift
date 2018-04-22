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
    func viewWillAppear()
    func didClickCreate()
    func didClickEdit()
}

// MARK: - Interactor

protocol ProfileInteractorInput: class {
    func fetchUserInfo()
}

// MARK: -
protocol ProfileInteractorOutput: class {
    func didFetchUser(_ user: User)
    func didReceiveFailure(_ error: Error)
}

// MARK: - Router

protocol ProfileRouterInput: class {
    func showConstructor()
    func showEditProfile()
}
