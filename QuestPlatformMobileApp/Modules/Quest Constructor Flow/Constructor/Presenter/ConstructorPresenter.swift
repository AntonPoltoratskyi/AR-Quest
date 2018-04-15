//
//  ConstructorPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorPresenter: Presenter, ConstructorModuleInput {
    
    typealias View = ConstructorViewInput
    typealias Interactor = ConstructorInteractorInput
    typealias Router = ConstructorRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - ConstructorViewOutput
extension ConstructorPresenter: ConstructorViewOutput {
    
}

// MARK: - ConstructorInteractorOutput
extension ConstructorPresenter: ConstructorInteractorOutput {
    
}
