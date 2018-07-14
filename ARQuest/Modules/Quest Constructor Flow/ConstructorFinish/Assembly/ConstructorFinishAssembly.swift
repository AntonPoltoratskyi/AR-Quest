//
//  ConstructorFinishAssembly.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishAssembly: Assembly {
    
    typealias Input = Module<ConstructorFinishModuleInput>
    
    private let quest: Quest
    private let code: String
    
    init(quest: Quest, code: String) {
        self.quest = quest
        self.code = code
    }
    
    func build() -> Input {
        let view = ConstructorFinishViewController()
        let presenter = ConstructorFinishPresenter()
        let interactor = ConstructorFinishInteractor()
        let router = ConstructorFinishRouter()
        
        view.output = presenter
        
        interactor.output = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.code = code
        
        return Module(input: presenter, view: view)
    }
}
