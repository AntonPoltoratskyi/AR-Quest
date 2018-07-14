//
//  LocationPickerInteractor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class LocationPickerInteractor: Interactor, LocationPickerInteractorInput {
    typealias Output = LocationPickerInteractorOutput
    weak var output: LocationPickerInteractorOutput!
}
