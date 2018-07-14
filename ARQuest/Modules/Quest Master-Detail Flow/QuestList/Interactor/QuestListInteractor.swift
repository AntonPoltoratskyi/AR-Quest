//
//  QuestListInteractor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class QuestListInteractor: Interactor, QuestListInteractorInput {
    
    typealias Output = QuestListInteractorOutput
    weak var output: QuestListInteractorOutput!
    
    // MARK: - Dependencies
    
    private let questNetworkService: QuestNetworkService
    
    
    // MARK: - Init
    
    init(questNetworkService: QuestNetworkService) {
        self.questNetworkService = questNetworkService
    }
    
    
    // MARK: - Actions
    
    func loadQuests() {
        output.didStartLoading()
        questNetworkService.loadQuests { [weak self] result in
            defer { self?.output?.didFinishLoading() }
            switch result {
            case let .success(quests):
                self?.output?.didLoadQuests(quests)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
