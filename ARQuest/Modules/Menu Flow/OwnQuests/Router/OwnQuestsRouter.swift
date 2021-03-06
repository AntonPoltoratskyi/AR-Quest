//
//  OwnQuestsRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 21.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class OwnQuestsRouter: Router, OwnQuestsRouterInput {
    
    weak var viewController: UIViewController!
    
    func showQuest(_ quest: Quest) {
        let module = QuestDetailsAssembly(quest: quest).build()
        viewController.navigationController?.pushViewController(module.view, animated: true)
    }
}
