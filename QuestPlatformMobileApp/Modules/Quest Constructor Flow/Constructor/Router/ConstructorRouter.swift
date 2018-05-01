//
//  ConstructorRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorRouter: Router, ConstructorRouterInput {
    
    weak var viewController: UIViewController!
    
    weak var output: ConstructorRouterOutput?
    
    func showTaskCreator() {
        let module = TaskBuilderAssembly().build()
        module.input.output = self
        viewController.navigationController?.pushViewController(module.view, animated: true)
    }
}

extension ConstructorRouter: TaskBuilderModuleOutput {
    
    func taskBuilderModule(_ moduleInput: TaskBuilderModuleInput, didCreateTask task: Task) {
        output?.didCreateTask(task)
        moduleInput.dismiss()
    }
}
