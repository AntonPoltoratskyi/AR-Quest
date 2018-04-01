//
//  QuestDetailsPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestDetailsPresenter: Presenter, QuestDetailsModuleInput {
    
    typealias View = QuestDetailsViewInput
    typealias Interactor = QuestDetailsInteractorInput
    typealias Router = QuestDetailsRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    var quest: Quest!
}

// MARK: - QuestDetailsViewOutput
extension QuestDetailsPresenter: QuestDetailsViewOutput {
    
}

// MARK: - QuestDetailsInteractorOutput
extension QuestDetailsPresenter: QuestDetailsInteractorOutput {
    
}
