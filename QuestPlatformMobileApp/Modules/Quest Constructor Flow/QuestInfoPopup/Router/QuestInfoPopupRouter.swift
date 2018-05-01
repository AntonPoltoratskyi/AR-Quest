//
//  QuestInfoPopupRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestInfoPopupRouter: Router, QuestInfoPopupRouterInput {
    
    weak var viewController: UIViewController!
    
    func dismiss(completion: (() -> Void)?)  {
        viewController.dismiss(animated: true, completion: completion)
    }
}
