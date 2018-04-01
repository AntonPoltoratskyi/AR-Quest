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
    
    func viewDidLoad() {
        let viewModel = MainViewModel(state: .loaded(nearbyEvents: 5))
        view.setup(viewModel)
    }
    
    func didClickJoin() {
        
    }
    
    func didClickSearch() {
        
    }
    
    func didClickProfile() {
        
    }
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
    
}
