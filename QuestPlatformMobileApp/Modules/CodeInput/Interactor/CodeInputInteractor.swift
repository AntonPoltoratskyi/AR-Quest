//
//  CodeInputInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class CodeInputInteractor: Interactor, CodeInputInteractorInput {
    typealias Output = CodeInputInteractorOutput
    weak var output: CodeInputInteractorOutput!
    
    // MARK: - Dependencies
    
    private let questNetworkService: QuestNetworkService
    
    
    // MARK: - Init
    
    init(questNetworkService: QuestNetworkService) {
        self.questNetworkService = questNetworkService
    }
    
    
    // MARK: - Actions
    
    func join(to questCode: String) {
        questNetworkService.joinToQuest(with: questCode) { [weak self] result in
            switch result {
            case let .success(quest):
                self?.output?.didJoin(to: quest)
            case let .failure(error):
                self?.output?.didReceiveError(error)
            }
        }
    }
}
