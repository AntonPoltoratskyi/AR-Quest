//
//  ARQuestAssembly.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ARQuestAssembly: Assembly {
    
    typealias Input = Module<ARQuestModuleInput>
    
    private let quest: Quest
    
    init(quest: Quest) {
        self.quest = quest
    }
    
    func build() -> Input {
        let trackingService = ARTrackingService()
        
        // Module
        let view = ARQuestViewController()
        let presenter = ARQuestPresenter(quest: quest, trackingService: trackingService)
        let interactor = ARQuestInteractor(locationService: .shared)
        let router = ARQuestRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        trackingService.delegate = presenter
        
        return Module(input: presenter, view: view)
    }
}
