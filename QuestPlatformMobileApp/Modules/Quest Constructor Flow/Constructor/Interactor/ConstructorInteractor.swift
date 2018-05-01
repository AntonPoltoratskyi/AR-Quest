//
//  ConstructorInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class ConstructorInteractor: Interactor, ConstructorInteractorInput {
    typealias Output = ConstructorInteractorOutput
    weak var output: ConstructorInteractorOutput!
    
    // MARK: - Dependencies
    
    private let questService: QuestNetworkService
    
    
    // MARK: - Init
    
    init(questService: QuestNetworkService) {
        self.questService = questService
    }
    
    
    // MARK: - Actions
    
    func create(_ quest: Quest) {
        questService.create(quest: quest) { [weak self] result in
            switch result {
            case let .success(response):
                self?.output?.didCreate(response.quest, withCode: response.code)
            case let .failure(error):
                self?.output?.didReceiveFailure(error)
            }
        }
    }
}
