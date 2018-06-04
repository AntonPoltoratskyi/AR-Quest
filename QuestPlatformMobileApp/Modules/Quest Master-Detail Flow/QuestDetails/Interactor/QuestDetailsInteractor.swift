//
//  QuestDetailsInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class QuestDetailsInteractor: Interactor, QuestDetailsInteractorInput {
    typealias Output = QuestDetailsInteractorOutput
    weak var output: QuestDetailsInteractorOutput!
    
    // MARK: - Dependencies
    
    private let questNetworkService: QuestNetworkService
    
    
    // MARK: - Init
    
    init(questNetworkService: QuestNetworkService) {
        self.questNetworkService = questNetworkService
    }
    
    
    // MARK: - Actions
    
    func loadTasks(for quest: Quest) {
        output.didStartLoading()
        questNetworkService.loadTasks(for: quest) { [weak self] result in
            defer { self?.output?.didFinishLoading() }
            switch result {
            case let .success(tasks):
                self?.output?.didLoadTasks(tasks)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
    
    func join(to quest: Quest) {
        output.didStartLoading()
        questNetworkService.join(to: quest) { [weak self] result in
            defer { self?.output?.didFinishLoading() }
            switch result {
            case let .success(quest):
                self?.output?.didJoin(to: quest)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
