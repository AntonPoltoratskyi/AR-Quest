//
//  SideMenuContainerPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol SideMenuContainerModuleInput: ModuleInput {
    func setupLeft(_ viewController: UIViewController)
    func setupCenter(_ viewController: UIViewController)
    func setupRight(_ viewController: UIViewController)
}

// MARK: - Presenter

final class SideMenuContainerPresenter: Presenter, SideMenuContainerModuleInput {
    
    typealias View = SideMenuContainerViewInput
    typealias Interactor = SideMenuContainerInteractorInput
    typealias Router = SideMenuContainerRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}


// MARK: - SideMenuContainerViewOutput
extension SideMenuContainerPresenter: SideMenuContainerViewOutput {
    
    func setupLeft(_ viewController: UIViewController) {
        view.setupLeft(viewController)
    }
    
    func setupCenter(_ viewController: UIViewController) {
        view.setupCenter(viewController)
    }
    
    func setupRight(_ viewController: UIViewController) {
        view.setupRight(viewController)
    }
}

// MARK: - SideMenuContainerInteractorOutput
extension SideMenuContainerPresenter: SideMenuContainerInteractorOutput {
    
}
