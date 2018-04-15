//
//  QuestListRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestListRouter: Router, QuestListRouterInput {
    
    weak var viewController: UIViewController!
    
    func showQuest(_ quest: Quest) {
        let questDetails = QuestDetailsAssembly(quest: quest).build()
        viewController.navigationController?.pushViewController(questDetails.view, animated: true)
    }
    
    func showCodeJoin() {
        let codeInput = CodeInputAssembly().build()
        viewController.navigationController?.pushViewController(codeInput.view, animated: true)
    }
}
