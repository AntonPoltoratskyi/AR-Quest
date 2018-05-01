//
//  QuestInfoPopupProtocols.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol QuestInfoPopupModuleInput: ModuleInput {
    var output: QuestInfoPopupModuleOutput? { get set }
    func dismiss(completion: (() -> Void)?)
}

protocol QuestInfoPopupModuleOutput: class {
    func questInfoPopup(_ moduleInput: QuestInfoPopupModuleInput, didSaveQuestWithTitle title: String, accessLevel: Quest.AccessLevel)
}

// MARK: - View

protocol QuestInfoPopupViewInput: class {
    
}

// MARK: -
protocol QuestInfoPopupViewOutput: class {
    func didTapSave(title: String?, accessLevel: Quest.AccessLevel)
}

// MARK: - Interactor

protocol QuestInfoPopupInteractorInput: class {
}

// MARK: -
protocol QuestInfoPopupInteractorOutput: class {
}

// MARK: - Router

protocol QuestInfoPopupRouterInput: class {
    func dismiss(completion: (() -> Void)?)
}
