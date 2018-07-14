//
//  ConstructorFinishPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class ConstructorFinishPresenter: Presenter, ConstructorFinishModuleInput {
    
    typealias View = ConstructorFinishViewInput
    typealias Interactor = ConstructorFinishInteractorInput
    typealias Router = ConstructorFinishRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    var code: String!
}

// MARK: - ConstructorFinishViewOutput
extension ConstructorFinishPresenter: ConstructorFinishViewOutput {
    
    func viewDidLoad() {
        view.setupCode(code)
    }
    
    func didTapDoneButton() {
        router.finish()
    }
}

// MARK: - ConstructorFinishInteractorOutput
extension ConstructorFinishPresenter: ConstructorFinishInteractorOutput {
    
}
