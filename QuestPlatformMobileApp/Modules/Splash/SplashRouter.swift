//
//  SplashRouter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol SplashRouterInput: class {
}

final class SplashRouter: Router, SplashRouterInput {
    weak var viewController: UIViewController!
}
