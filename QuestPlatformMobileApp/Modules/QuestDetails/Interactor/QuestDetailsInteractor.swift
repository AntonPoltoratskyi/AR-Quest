//
//  QuestDetailsInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class QuestDetailsInteractor: Interactor, QuestDetailsInteractorInput {
    typealias Output = QuestDetailsInteractorOutput
    weak var output: QuestDetailsInteractorOutput!
}
