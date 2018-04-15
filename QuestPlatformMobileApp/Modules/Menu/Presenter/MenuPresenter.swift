//
//  MenuPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuPresenter: Presenter, MenuModuleInput {
    
    typealias View = MenuViewInput
    typealias Interactor = MenuInteractorInput
    typealias Router = MenuRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - MenuViewOutput
extension MenuPresenter: MenuViewOutput {
    
}

// MARK: - MenuInteractorOutput
extension MenuPresenter: MenuInteractorOutput {
    
}
