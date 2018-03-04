//
//  LoginRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LoginRouterInput: class {
}

final class LoginRouter: Router, LoginRouterInput {
    
    weak var viewController: UIViewController!
}
