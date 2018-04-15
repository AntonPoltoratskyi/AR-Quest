//
//  MainRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MainRouter: Router, MainRouterInput {
    
    weak var viewController: UIViewController!
    
    func showQuestList() {
        let questList = QuestListAssembly().build()
        viewController.navigationController?.pushViewController(questList.view, animated: true)
    }
    
    func showMenu() {
        let menu = MenuAssembly().build()
        viewController.present(menu.view, animated: true, completion: nil)
    }
}
