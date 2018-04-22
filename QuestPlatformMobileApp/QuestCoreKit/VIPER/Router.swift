//
//  Router.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol Router: class {
    var viewController: UIViewController! { get }
}

extension Router {
    
    func presentAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        let actions = [okAction]
        
        actions.forEach { alert.addAction($0) }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
