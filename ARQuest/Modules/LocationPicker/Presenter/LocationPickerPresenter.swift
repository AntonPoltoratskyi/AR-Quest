//
//  LocationPickerPresenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import CoreLocation

final class LocationPickerPresenter: Presenter, LocationPickerModuleInput {
    
    typealias View = LocationPickerViewInput
    typealias Interactor = LocationPickerInteractorInput
    typealias Router = LocationPickerRouterInput
    
    weak var view: View!
    var interactor: Interactor!
    var router: Router!
    
    weak var output: LocationPickerModuleOutput?
 
    private var selectedCoordinate: Coordinate?
}

// MARK: - LocationPickerViewOutput
extension LocationPickerPresenter: LocationPickerViewOutput {
    
    func didSelectCoordinate(_ coordinate: Coordinate) {
        selectedCoordinate = coordinate
    }
    
    func didClickDone() {
        guard let selectedCoordinate = selectedCoordinate else {
            router.presentAlert(title: "Suggestion", message: "Please, select a location", handler: nil)
            return
        }
        output?.didSelectLocation(at: selectedCoordinate)
        router.finish()
    }
    
    func didClickCancel() {
        router.finish()
    }
}

// MARK: - LocationPickerInteractorOutput
extension LocationPickerPresenter: LocationPickerInteractorOutput {
    
}
