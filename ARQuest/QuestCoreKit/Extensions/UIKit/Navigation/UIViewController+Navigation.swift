//
//  UIViewController+Navigation.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 10/17/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public extension UIViewController {
    public func lastPresentedViewController() -> UIViewController? {
        return presentedViewController?.lastPresentedViewController() ?? self
    }
}
