//
//  TaskBuilderRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class TaskBuilderRouter: Router, TaskBuilderRouterInput {
    
    weak var viewController: UIViewController!
    
    func dismiss() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func showLocationPicker(delegate: LocationPickerModuleOutput) {
        let module = LocationPickerAssembly().build()
        module.input.output = delegate
        viewController.navigationController?.pushViewController(module.view, animated: true)
    }
}
