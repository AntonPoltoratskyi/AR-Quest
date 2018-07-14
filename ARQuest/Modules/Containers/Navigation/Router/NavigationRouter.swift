//
//  NavigationRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol NavigationRouterInput: class {
}

final class NavigationRouter: Router, NavigationRouterInput {
    
    weak var viewController: UIViewController!
}
