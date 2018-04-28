//
//  QuestInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class QuestInteractor: Interactor, QuestInteractorInput {
    typealias Output = QuestInteractorOutput
    weak var output: QuestInteractorOutput!
}
