//
//  ProfileInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class ProfileInteractor: Interactor, ProfileInteractorInput {
    typealias Output = ProfileInteractorOutput
    weak var output: ProfileInteractorOutput!
}
