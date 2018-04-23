//
//  TaskBuilderPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderPresenter: Presenter, TaskBuilderModuleInput {
    
    typealias View = TaskBuilderViewInput
    typealias Interactor = TaskBuilderInteractorInput
    typealias Router = TaskBuilderRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    weak var output: TaskBuilderModuleOutput?
}

// MARK: - TaskBuilderViewOutput
extension TaskBuilderPresenter: TaskBuilderViewOutput {
    
}

// MARK: - TaskBuilderInteractorOutput
extension TaskBuilderPresenter: TaskBuilderInteractorOutput {
    
}
