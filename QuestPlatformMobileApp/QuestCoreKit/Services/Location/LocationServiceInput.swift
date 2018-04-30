//
//  LocationServiceInput.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationSubscriber = AnyObject

typealias LocationAuthorizationStatusHandler = (CLAuthorizationStatus) -> Void
typealias LocationHandler = (CLLocation) -> Void
typealias HeadingHandler = (CLHeading) -> Void
typealias PlacemarkHandler = (CLPlacemark) -> Void
typealias LocationErrorHandler = (Error) -> Void


protocol LocationServiceInput: class {
    var isLocationUpdatesAvailable: Bool { get }
    var isAuthorized: Bool { get}
    
    /// Service will attempt to geocode received coordinate into placemark object
    var isGeocodingEnabled: Bool { get set }
    
    var lastReceivedLocation: Coordinate? { get }
    var lastReceivedPlacemark: CLPlacemark? { get}
    
    func startLocationTracking()
    func stopLocationTracking()
    
    func observeAuthorizationStatus(_ subscriber: LocationSubscriber, handler: @escaping LocationAuthorizationStatusHandler)
    func observeLocationUpdates(_ subscriber: LocationSubscriber, handler: @escaping LocationHandler)
    func observeHeadingUpdates(_ subscriber: LocationSubscriber, handler: @escaping HeadingHandler)
    func observePlacemarkUpdates(_ subscriber: LocationSubscriber, handler: @escaping PlacemarkHandler)
    func observeErrors(_ subscriber: LocationSubscriber, handler: @escaping LocationErrorHandler)
    
    func removeSubscriber(_ subscriber: LocationSubscriber)
}
