//
//  ConstructorFinishRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishRouter: Router, ConstructorFinishRouterInput {
    
    weak var viewController: UIViewController!
    
    func finish() {
        let module = OwnQuestsAssembly().build()
        viewController.navigationController?.setViewControllers([module.view], animated: true)
    }
}
