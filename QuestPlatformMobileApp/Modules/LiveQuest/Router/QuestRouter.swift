//
//  QuestRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestRouter: Router, QuestRouterInput {
    
    weak var viewController: UIViewController!
    
    func showFinish(for quest: Quest) {
        let alert = UIAlertController(
            title: "Congratulations!",
            message: "You have just finised quest '\(quest.name)'",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let module = OwnQuestsAssembly().build()
            self.viewController.navigationController?.setViewControllers([module.view], animated: true)
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
