//
//  LocationRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LocationRouterInput: class {
}

final class LocationRouter: Router, LocationRouterInput {
    
    weak var viewController: UIViewController!
}
