//
//  CodeInputPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class CodeInputPresenter: Presenter, CodeInputModuleInput {
    
    typealias View = CodeInputViewInput
    typealias Interactor = CodeInputInteractorInput
    typealias Router = CodeInputRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - CodeInputViewOutput
extension CodeInputPresenter: CodeInputViewOutput {
    
}

// MARK: - CodeInputInteractorOutput
extension CodeInputPresenter: CodeInputInteractorOutput {
    
}
