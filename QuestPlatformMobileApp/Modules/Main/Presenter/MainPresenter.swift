//
//  MainPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol MainModuleInput: ModuleInput {
}

// MARK: - Presenter

final class MainPresenter: Presenter, MainModuleInput {
    
    typealias View = MainViewInput
    typealias Interactor = MainInteractorInput
    typealias Router = MainRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}


// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
    
}
