//
//  QuestInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

final class QuestInteractor: Interactor, QuestInteractorInput {
    typealias Output = QuestInteractorOutput
    weak var output: QuestInteractorOutput!
    
    private var receivedLocations: [CLLocation] = []
    
    
    // MARK: - Dependencies
    
    private let navigationService: NavigationService
    
    
    // MARK: - Init
    
    init(navigationService: NavigationService) {
        self.navigationService = navigationService
        self.navigationService.delegate = self
    }
    
    
    // MARK: - Input
    
    func startLocationUpdates() {
        navigationService.launchUpdating()
    }
    
    func stopLocationUpdates() {
        
    }
}

// MARK: - NavigationServiceDelegate
extension QuestInteractor: NavigationServiceDelegate {
    
    func navigationService(_ service: NavigationService, didReceiveNoAuthorization state: CLAuthorizationStatus) {
        
    }
    
    func navigationService(_ service: NavigationService, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        output.handleUpdatedLocation(location, previousLocation: receivedLocations.last)
        
        receivedLocations.append(location)
    }
    
    func navigationService(_ service: NavigationService, didUpdateHeading newHeading: CLHeading) {
        output.handleUpdatedHeading(newHeading)
    }
    
    func navigationService(_ service: NavigationService, didFailWithError error: Error) {
        output.handleLocationUpdateFailure(error)
    }
}
