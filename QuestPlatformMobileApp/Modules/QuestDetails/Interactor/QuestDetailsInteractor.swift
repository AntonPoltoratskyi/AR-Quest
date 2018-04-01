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
    
    var questNetworkService: QuestNetworkService!
    
    func loadTasks(for quest: Quest) {
        questNetworkService.loadTasks(for: quest) { [weak self] result in
            switch result {
            case let .success(tasks):
                self?.output?.didLoadTasks(tasks)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
