//
//  LocationPresenter.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Module Input

protocol LocationModuleInput: ModuleInput {
}

// MARK: - Presenter

final class LocationPresenter: Presenter, LocationModuleInput {
    
    typealias View = LocationViewInput
    typealias Interactor = LocationInteractorInput
    typealias Router = LocationRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
}


// MARK: - LocationViewOutput
extension LocationPresenter: LocationViewOutput {
    
}

// MARK: - LocationInteractorOutput
extension LocationPresenter: LocationInteractorOutput {
    
}
