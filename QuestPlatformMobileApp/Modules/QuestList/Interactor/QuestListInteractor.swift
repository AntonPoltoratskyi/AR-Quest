//
//  QuestListInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class QuestListInteractor: Interactor, QuestListInteractorInput {
    
    typealias Output = QuestListInteractorOutput
    weak var output: QuestListInteractorOutput!
    
    var questNetworkService: QuestNetworkService!
    
    func loadQuests() {
        questNetworkService.loadQuests { [weak self] result in
            switch result {
            case let .success(quests):
                self?.output?.didLoadQuests(quests)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
