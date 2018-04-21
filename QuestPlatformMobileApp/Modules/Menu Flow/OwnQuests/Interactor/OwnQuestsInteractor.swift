//
//  OwnQuestsInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class OwnQuestsInteractor: Interactor, OwnQuestsInteractorInput {
    typealias Output = OwnQuestsInteractorOutput
    weak var output: OwnQuestsInteractorOutput!
    
    // MARK: - Dependencies
    
    private let questNetworkService: QuestNetworkService
    
    
    // MARK: - Init
    
    init(questNetworkService: QuestNetworkService) {
        self.questNetworkService = questNetworkService
    }
    
    
    // MARK: - Actions
    
    func loadQuests() {
        questNetworkService.loadOwnQuests { [weak self] result in
            switch result {
            case let .success(quests):
                self?.output?.didLoadQuests(quests)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
