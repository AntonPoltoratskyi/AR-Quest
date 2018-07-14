//
//  QuestInfoPopupPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestInfoPopupPresenter: Presenter, QuestInfoPopupModuleInput {
    
    typealias View = QuestInfoPopupViewInput
    typealias Interactor = QuestInfoPopupInteractorInput
    typealias Router = QuestInfoPopupRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    weak var output: QuestInfoPopupModuleOutput?
    
    func dismiss(completion: (() -> Void)?) {
        router.dismiss(completion: completion)
    }
}

// MARK: - QuestInfoPopupViewOutput
extension QuestInfoPopupPresenter: QuestInfoPopupViewOutput {
    
    func didTapSave(title: String?, accessLevel: Quest.AccessLevel) {
        guard let title = title, !title.isEmpty else {
            return
        }
        output?.questInfoPopup(self, didSaveQuestWithTitle: title, accessLevel: accessLevel)
    }
}

// MARK: - QuestInfoPopupInteractorOutput
extension QuestInfoPopupPresenter: QuestInfoPopupInteractorOutput {
    
}
