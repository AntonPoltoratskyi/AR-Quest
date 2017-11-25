//
//  UIResources.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/10/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case login      = "Login"
    case home       = "Home"
    
    var name: String {
        return rawValue
    }
}

extension UIStoryboard {
    static let login = UIStoryboard(name: Storyboard.login.name, bundle: nil)
    static let home = UIStoryboard(name: Storyboard.home.name, bundle: nil)
    
    func initialViewController() -> UIViewController? {
        return instantiateInitialViewController()
    }
    func viewController<T: UIViewController>(ofType type: T.Type) -> T? {
        let identifier = String(describing: type)
        return instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension UINib {
    static func nib(named nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}

extension UIViewController {
    static func instantiateFromNib<T: UIViewController>(ofType type: T.Type) -> T {
        let nibName = String(describing: type)
        return T(nibName: nibName, bundle: nil)
    }
    
    static func instantiateFromNib() -> Self {
        return instantiateFromNib(ofType: self)
    }
}
