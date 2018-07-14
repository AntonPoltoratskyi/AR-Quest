//
//  MenuRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class MenuRouter: Router, MenuRouterInput {
    
    weak var viewController: UIViewController!
    
    func showProfile() {
        let module = ProfileAssembly().build()
        pushModule(module.view)
    }
    
    func showPublicQuests() {
        let module = QuestListAssembly().build()
        pushModule(module.view)
    }
    
    func showMyQuests() {
        let module = OwnQuestsAssembly().build()
        pushModule(module.view)
    }
    
    func startNewQuest() {
        let module = ConstructorAssembly().build()
        pushModule(module.view)
    }
    
    func showAbout() {
        let module = AboutAssembly().build()
        pushModule(module.view)
    }
    
    func performLogout() {
        perform {
            self.viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    private func pushModule(_ view: UIViewController) {
        perform {
            let navigation = self.viewController.sideMenuController?.rootViewController as? UINavigationController
            navigation?.setViewControllers([view], animated: true)
        }
    }
    
    private func perform(completion: @escaping () -> Void) {
        viewController.sideMenuController?.hideLeftView(animated: true, completionHandler: completion)
    }
}
