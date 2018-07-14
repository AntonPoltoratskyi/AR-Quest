//
//  SideMenuContainerViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import LGSideMenuController

protocol SideMenuContainerViewInput: class {
    func setupLeft(_ viewController: UIViewController)
    func setupCenter(_ viewController: UIViewController)
    func setupRight(_ viewController: UIViewController)
}

protocol SideMenuContainerViewOutput: class {
}

final class SideMenuContainerViewController: LGSideMenuController, View {
    
    typealias Output = SideMenuContainerViewOutput
    var output: Output!
}

// MARK: - SideMenuContainerViewInput
extension SideMenuContainerViewController: SideMenuContainerViewInput {
    
    func setupLeft(_ viewController: UIViewController) {
        leftViewController = viewController
    }
    
    func setupCenter(_ viewController: UIViewController) {
        rootViewController = viewController
    }
    
    func setupRight(_ viewController: UIViewController) {
        rightViewController = viewController
    }
}
