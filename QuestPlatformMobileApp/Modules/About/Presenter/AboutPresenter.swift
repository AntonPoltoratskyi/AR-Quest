//
//  AboutPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class AboutPresenter: Presenter, AboutModuleInput {
    
    typealias View = AboutViewInput
    typealias Interactor = AboutInteractorInput
    typealias Router = AboutRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - AboutViewOutput
extension AboutPresenter: AboutViewOutput {
    
}

// MARK: - AboutInteractorOutput
extension AboutPresenter: AboutInteractorOutput {
    
}
