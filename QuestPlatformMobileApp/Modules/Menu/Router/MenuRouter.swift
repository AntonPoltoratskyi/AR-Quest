//
//  MenuRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol MenuRouterInput: class {
}

final class MenuRouter: Router, MenuRouterInput {
    
    weak var viewController: UIViewController!
}
