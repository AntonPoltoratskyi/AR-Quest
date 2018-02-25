//
//  SplashPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol SplashModuleInput: ModuleInput {
}

final class SplashPresenter: SplashModuleInput, Presenter {

    typealias View = SplashViewInput
    typealias Interactor = SplashInteractorInput
    typealias Router = SplashRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    
}

extension SplashPresenter: SplashViewOutput {
    
}

extension SplashPresenter: SplashInteractorOutput {
    
}
