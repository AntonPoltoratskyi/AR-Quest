//
//  ARQuestInteractor.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

final class ARQuestInteractor: Interactor, ARQuestInteractorInput {
    typealias Output = ARQuestInteractorOutput
    weak var output: ARQuestInteractorOutput!
    
    private var receivedLocations: [CLLocation] = []
    private let cacheSize = 500
    
    
    // MARK: - Dependencies
    
    private let locationService: LocationService
    
    
    // MARK: - Init
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    deinit {
        locationService.removeSubscriber(self)
        deinited(self)
    }
    
    
    // MARK: - Input
    
    func startLocationUpdates() {
        locationService.observeAuthorizationStatus(self) { [weak self] status in
            guard let `self` = self else { return }
            self.output?.didChangeLocationAuthorizationStatus(status)
        }
        locationService.observeLocationUpdates(self) { [weak self] location in
            guard let `self` = self else { return }
            
            let previousLocation = self.receivedLocations.last
            self.receivedLocations.append(location)
            
            if self.receivedLocations.count > self.cacheSize {
                self.receivedLocations.removeFirst(self.cacheSize / 2)
            }
            self.output?.didUpdateLocation(location, previousLocation: previousLocation)
        }
        locationService.observeHeadingUpdates(self) { [weak self] heading in
            guard let `self` = self else { return }
            self.output?.didUpdateHeading(heading)
        }
        locationService.observeErrors(self) { [weak self] error in
            guard let `self` = self else { return }
            self.output?.didReceiveLocationFailure(error)
        }
        locationService.startLocationTracking()
    }
    
    func stopLocationUpdates() {
        locationService.stopLocationTracking()
    }
}
