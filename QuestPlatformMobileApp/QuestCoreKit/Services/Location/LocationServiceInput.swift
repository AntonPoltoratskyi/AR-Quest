//
//  LocationServiceInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationAuthorizationStatusHandler = (CLAuthorizationStatus) -> Void
typealias LocationHandler = (Coordinate) -> Void
typealias PlacemarkHandler = (CLPlacemark) -> Void

typealias LocationSubscriber = AnyObject

protocol LocationServiceInput: class {
    var isLocationUpdatesAvailable: Bool { get }
    var isAuthorized: Bool { get}
    
    var lastReceivedLocation: Coordinate? { get }
    var lastReceivedPlacemark: CLPlacemark? { get}
    
    func startLocationTracking()
    func stopLocationTracking()
    
    func observeAuthorizationStatus(_ subscriber: LocationSubscriber, handler: @escaping LocationAuthorizationStatusHandler)
    
    func observeLocationUpdates(_ subscriber: LocationSubscriber, handler: @escaping LocationHandler)
    func getCurrentLocation(completion: @escaping LocationHandler)
    
    func observePlacemarkUpdates(_ subscriber: LocationSubscriber, handler: @escaping PlacemarkHandler)
    func getCurrentPlacemark(completion: @escaping PlacemarkHandler)
    
    func removeSubscriber(_ subscriber: LocationSubscriber)
}
