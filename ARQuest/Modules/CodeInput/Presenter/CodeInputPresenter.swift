//
//  CodeInputPresenter.swift
//  ARQuest
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
    
    func didClickJoin(to questCode: String?) {
        // TODO: validate
        do {
            let validCode = try CodeValidator().validated(questCode)
            interactor.join(to: validCode)
        } catch {
            if let error = error as? ErrorRepresentable {
                view.showError(error.errorMessage)
            }
        }
    }
}

// MARK: - CodeInputInteractorOutput
extension CodeInputPresenter: CodeInputInteractorOutput {
    
    func didJoin(to quest: Quest) {
        router.join(to: quest)
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
