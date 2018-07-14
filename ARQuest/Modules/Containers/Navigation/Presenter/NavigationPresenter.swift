//
//  NavigationPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol NavigationModuleInput: ModuleInput {
}

// MARK: - Presenter

final class NavigationPresenter: Presenter, NavigationModuleInput {
    
    typealias View = NavigationViewInput
    typealias Interactor = NavigationInteractorInput
    typealias Router = NavigationRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}


// MARK: - NavigationViewOutput
extension NavigationPresenter: NavigationViewOutput {
    
}

// MARK: - NavigationInteractorOutput
extension NavigationPresenter: NavigationInteractorOutput {
    
}
