//
//  ProfileRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ProfileRouter: Router, ProfileRouterInput {
    
    weak var viewController: UIViewController!
    
    func showConstructor() {
        let constructor = ConstructorAssembly().build()
        viewController.navigationController?.pushViewController(constructor.view, animated: true)
    }
}
