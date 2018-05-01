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
    
    private var tasks: [Task] = []
}

// MARK: - ConstructorViewOutput
extension ConstructorPresenter: ConstructorViewOutput {
    
    func didClickAddTask() {
        router.showTaskCreator()
    }
    
    func didClickDone(tasks: [Task]) {
        guard !tasks.isEmpty else {
            return
        }
        self.tasks = tasks
        router.showQuestInfoPopup(delegate: self)
    }
}

// MARK: - ConstructorInteractorOutput
extension ConstructorPresenter: ConstructorInteractorOutput {
    
    func didCreate(_ quest: Quest, withCode code: String) {
        router.showConstructorFinish(for: quest, code: code)
    }
    
    func didReceiveFailure(_ error: Error) {
        
    }
}

// MARK: - ConstructorRouterOutput
extension ConstructorPresenter: ConstructorRouterOutput {
    
    func didCreateTask(_ task: Task) {
        view.addTask(task)
    }
}

// MARK: - QuestInfoPopupModuleOutput
extension ConstructorPresenter: QuestInfoPopupModuleOutput {
    
    func questInfoPopup(_ moduleInput: QuestInfoPopupModuleInput, didSaveQuestWithTitle title: String, accessLevel: Quest.AccessLevel) {
        
        moduleInput.dismiss {
            guard let user = SessionStorage.shared.user else {
                return
            }
            let quest = Quest(name: title, status: .waiting, accessLevel: accessLevel, tasks: self.tasks, owner: user)
            self.interactor.create(quest)
        }
    }
}
