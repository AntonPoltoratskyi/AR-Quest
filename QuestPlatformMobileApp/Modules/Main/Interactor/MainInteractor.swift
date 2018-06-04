//
//  MainInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class MainInteractor: Interactor, MainInteractorInput {
    
    typealias Output = MainInteractorOutput
    weak var output: MainInteractorOutput!
    
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
                self?.output?.didLoadQuestCount(quests.count)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
