//
//  QuestDetailsPresenter.swift
//  ARQuest
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
    
    func viewDidLoad() {
        view.setupQuestInfo(quest)
        interactor.loadTasks(for: quest)
    }
    
    func didClickJoin() {
        interactor.join(to: quest)
    }
}

// MARK: - QuestDetailsInteractorOutput
extension QuestDetailsPresenter: QuestDetailsInteractorOutput {
    
    func didLoadTasks(_ tasks: [Task]) {
        view.setupTasks(tasks.map { QuestTaskCellModel(task: $0) })
    }
    
    func didJoin(to quest: Quest) {
        router.join(to: quest)
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
