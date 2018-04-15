//
//  LocationPickerPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationPickerPresenter: Presenter, LocationPickerModuleInput {
    
    typealias View = LocationPickerViewInput
    typealias Interactor = LocationPickerInteractorInput
    typealias Router = LocationPickerRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}

// MARK: - LocationPickerViewOutput
extension LocationPickerPresenter: LocationPickerViewOutput {
    
}

// MARK: - LocationPickerInteractorOutput
extension LocationPickerPresenter: LocationPickerInteractorOutput {
    
}
