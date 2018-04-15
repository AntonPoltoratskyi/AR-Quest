//
//  QuestConstructorPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestConstructorPresenter: Presenter, QuestConstructorModuleInput {
    
    typealias View = QuestConstructorViewInput
    typealias Interactor = QuestConstructorInteractorInput
    typealias Router = QuestConstructorRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - QuestConstructorViewOutput
extension QuestConstructorPresenter: QuestConstructorViewOutput {
    
}

// MARK: - QuestConstructorInteractorOutput
extension QuestConstructorPresenter: QuestConstructorInteractorOutput {
    
}
