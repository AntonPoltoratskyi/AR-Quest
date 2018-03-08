//
//  LocationInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol LocationInteractorInput: class {
}

protocol LocationInteractorOutput: class {
}

final class LocationInteractor: Interactor, LocationInteractorInput {
    typealias Output = LocationInteractorOutput
    weak var output: LocationInteractorOutput!
}
