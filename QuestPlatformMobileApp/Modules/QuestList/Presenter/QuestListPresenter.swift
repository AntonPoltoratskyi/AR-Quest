//
//  QuestListPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestListPresenter: Presenter, QuestListModuleInput {
    
    typealias View = QuestListViewInput
    typealias Interactor = QuestListInteractorInput
    typealias Router = QuestListRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - QuestListViewOutput
extension QuestListPresenter: QuestListViewOutput {
    
    func viewDidLoad() {
        interactor.loadQuests()
    }
}

// MARK: - QuestListInteractorOutput
extension QuestListPresenter: QuestListInteractorOutput {
    
    func didLoadQuests(_ quests: [Quest]) {
        view.setupQuests(quests.map { QuestCellModel(quest: $0) })
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
