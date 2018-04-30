//
//  LocationService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/20/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    private enum State {
        case none
        case singleLocationRequest  // single request
        case locationUpdates        // continual location updates
    }
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    private var lastAcquiredLocation: CLLocation?
    private var lastAcquiredPlacemark: CLPlacemark?
    
    private var locationOnceCompletions: [LocationHandler] = []
    private var placemarkOnceCompletions: [PlacemarkHandler] = []
    
    private var authorizationStatusSubscribers: [SubscriberContainer<LocationAuthorizationStatusHandler>] = []
    private var locationSubscribers: [SubscriberContainer<LocationHandler>] = []
    private var placemarkSubscribers: [SubscriberContainer<PlacemarkHandler>] = []
    
    private var state: State = .none {
        didSet {
            switch state {
            case .none:
                self.locationManager.stopUpdatingLocation()
            case .singleLocationRequest:
                if self.isAuthorized {
                    self.locationManager.requestLocation()
                } else {
                    self.locationManager.requestAlwaysAuthorization()
                }
            case .locationUpdates:
                if self.isAuthorized {
                    self.locationManager.startUpdatingLocation()
                } else {
                    self.locationManager.requestAlwaysAuthorization()
                }
            }
        }
    }
    
    var isLocationUpdatesAvailable: Bool {
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return isAuthorized || authStatus == .notDetermined
    }
    
    var isAuthorized: Bool {
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() && (authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse)
    }
    
    
    // MARK: - Init
    
    override init() {
        super.init()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

// MARK: - LocationServiceInput
extension LocationService: LocationServiceInput {
    
    func startLocationTracking() {
        state = .locationUpdates
    }
    
    func stopLocationTracking() {
        state = .none
    }
    
    var lastReceivedLocation: Coordinate? {
        return lastAcquiredLocation?.coordinate
    }
    
    var lastReceivedPlacemark: CLPlacemark? {
        return lastAcquiredPlacemark
    }
    
    func observeAuthorizationStatus(_ subscriber: LocationSubscriber, handler: @escaping LocationAuthorizationStatusHandler) {
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        authorizationStatusSubscribers.append(container)
        state = .locationUpdates
    }
    
    func observeLocationUpdates(_ subscriber: LocationSubscriber, handler: @escaping LocationHandler) {
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        locationSubscribers.append(container)
        state = .locationUpdates
    }
    
    func getCurrentLocation(completion: @escaping LocationHandler) {
        locationOnceCompletions.append(completion)
        state = .singleLocationRequest
    }
    
    func observePlacemarkUpdates(_ subscriber: LocationSubscriber, handler: @escaping PlacemarkHandler) {
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        placemarkSubscribers.append(container)
        state = .locationUpdates
    }
    
    func getCurrentPlacemark(completion: @escaping PlacemarkHandler) {
        placemarkOnceCompletions.append(completion)
        state = .singleLocationRequest
    }
    
    func removeSubscriber(_ subscriber: LocationSubscriber) {
        locationSubscribers = locationSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        placemarkSubscribers = placemarkSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        authorizationStatusSubscribers = authorizationStatusSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            debugPrint("Access to location not determined", inCase: .location)
        case .restricted, .denied:
            debugPrint("Access to location denied", inCase: .location)
            self.state = .none
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("Access to location granted", inCase: .location)
            // Start updating location only after success authorization
            self.continueLocationUpdates()
        }
    }
    
    private func continueLocationUpdates() {
        switch self.state {
        case .none:
            break
        case .locationUpdates:
            locationManager.startUpdatingLocation()
        case .singleLocationRequest:
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        self.lastAcquiredLocation = currentLocation
        
        handleReceivedCoordinate(currentLocation.coordinate)

        reverseGeocodeLocation(currentLocation) { [weak self] result in
            switch result {
            case let .success(placemark):
                self?.lastAcquiredPlacemark = placemark
                self?.handleReceivedPlacemar(placemark)
            case let .failure(error):
                debugPrint("Did receive error while try to get placemark for location: \(currentLocation), error: \(error)", inCase: .location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    private func reverseGeocodeLocation(_ location: CLLocation, completion: @escaping (Result<CLPlacemark>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                completion(.success(placemark))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    private func handleReceivedCoordinate(_ coordinate: Coordinate) {
        for subscriber in locationSubscribers {
            subscriber.handler?(coordinate)
        }
        for completion in locationOnceCompletions {
            completion(coordinate)
        }
        locationOnceCompletions.removeAll()
    }
    
    private func handleReceivedPlacemar(_ placemark: CLPlacemark) {
        for subscriber in placemarkSubscribers {
            subscriber.handler?(placemark)
        }
        for completion in placemarkOnceCompletions {
            completion(placemark)
        }
        placemarkOnceCompletions.removeAll()
    }
}
