//
//  EditProfileRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class EditProfileRouter: Router, EditProfileRouterInput {
    
    weak var viewController: UIViewController!
    
    func finish() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
