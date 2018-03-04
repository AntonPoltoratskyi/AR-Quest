//
//  ModuleInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol ModuleInput: class {
    var viewController: UIViewController? { get }
}

extension ModuleInput where Self: Presenter {
    var viewController: UIViewController? {
        return view as? UIViewController
    }
}
