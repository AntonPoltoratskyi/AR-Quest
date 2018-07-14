//
//  OwnQuestsPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class OwnQuestsPresenter: Presenter, OwnQuestsModuleInput {
    
    typealias View = OwnQuestsViewInput
    typealias Interactor = OwnQuestsInteractorInput
    typealias Router = OwnQuestsRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - OwnQuestsViewOutput
extension OwnQuestsPresenter: OwnQuestsViewOutput {
    
    func viewDidLoad() {
        interactor.loadQuests()
    }
    
    func didSelectQuest(_ questModel: QuestCellModel) {
        router.showQuest(questModel.quest)
    }
}

// MARK: - OwnQuestsInteractorOutput
extension OwnQuestsPresenter: OwnQuestsInteractorOutput {
    
    func didLoadQuests(_ quests: [Quest]) {
        view.setupQuests(quests.map { QuestCellModel(quest: $0) })
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
