//
//  QuestPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestPresenter: Presenter, QuestModuleInput {
    
    typealias View = QuestViewInput
    typealias Interactor = QuestInteractorInput
    typealias Router = QuestRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - QuestViewOutput
extension QuestPresenter: QuestViewOutput {
    
}

// MARK: - QuestInteractorOutput
extension QuestPresenter: QuestInteractorOutput {
    
}
