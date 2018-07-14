//
//  LocationPickerRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationPickerRouter: Router, LocationPickerRouterInput {
    
    weak var viewController: UIViewController!
    
    func finish() {
        if let navigation = viewController.navigationController {
            navigation.popViewController(animated: true)
        } else {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
