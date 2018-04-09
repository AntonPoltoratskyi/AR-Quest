//
//  AboutInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class AboutInteractor: Interactor, AboutInteractorInput {
    typealias Output = AboutInteractorOutput
    weak var output: AboutInteractorOutput!
}
