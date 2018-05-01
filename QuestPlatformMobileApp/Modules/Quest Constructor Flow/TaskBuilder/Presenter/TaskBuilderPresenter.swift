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
    
    private var selectedLocation: Coordinate?
    
    func dismiss() {
        router.dismiss()
    }
}

// MARK: - TaskBuilderViewOutput
extension TaskBuilderPresenter: TaskBuilderViewOutput {
    
    func didTapDone(title: String?, text: String?) {
        guard let title = title, !title.isEmpty else {
            return
        }
        
        var goal: Task.Goal?
        if let text = text {
            goal = .hint(text)
        } else if let location = selectedLocation {
            goal = .location(location)
        }
        
        if let goal = goal {
            let task = Task(name: title, goal: goal)
            output?.taskBuilderModule(self, didCreateTask: task)
        }
    }
    
    func didTapSelectLocation() {
        router.showLocationPicker(delegate: self)
    }
}

// MARK: - LocationPickerModuleOutput
extension TaskBuilderPresenter: LocationPickerModuleOutput {
    
    func didSelectLocation(at coordinate: Coordinate) {
        selectedLocation = coordinate
        view.setupSelectedLocation(coordinate)
    }
}

// MARK: - TaskBuilderInteractorOutput
extension TaskBuilderPresenter: TaskBuilderInteractorOutput {
    
}
