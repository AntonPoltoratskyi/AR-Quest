//
//  MainPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class MainPresenter: Presenter, MainModuleInput {
    
    typealias View = MainViewInput
    typealias Interactor = MainInteractorInput
    typealias Router = MainRouter
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    
    func viewDidLoad() {
        let viewModel = MainViewModel(state: .loading)
        view.setup(viewModel)
        
        interactor.loadQuests()
    }
    
    func didClickJoin() {
        router.showQuestList()
    }
    
    func didClickSearch() {
        
    }
    
    func didClickProfile() {
        
    }
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
    
    func didLoadQuestCount(_ count: Int) {
        let viewModel = MainViewModel(state: .loaded(nearbyEvents: 5))
        view.setup(viewModel)
    }
    
    func didReceiveError(_ error: Error) {
    }
}
