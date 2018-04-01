//
//  MainRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol MainRouterInput: class {
    func showQuestList()
}

final class MainRouter: Router, MainRouterInput {
    
    weak var viewController: UIViewController!
    
    func showQuestList() {
        let questList = QuestListAssembly().build()
        viewController.navigationController?.pushViewController(questList.view, animated: true)
    }
}
