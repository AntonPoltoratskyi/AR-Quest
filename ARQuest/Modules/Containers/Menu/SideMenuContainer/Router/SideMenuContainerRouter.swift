//
//  SideMenuContainerRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol SideMenuContainerRouterInput: class {
}

final class SideMenuContainerRouter: Router, SideMenuContainerRouterInput {
    
    weak var viewController: UIViewController!
}
