//
//  LocationService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/20/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationSubscriber = AnyObject

typealias LocationCompletion = (Result<Location>) -> Void
typealias PlacemarkCompletion = (Result<CLPlacemark>) -> Void

struct Location {
    var latitude: Double
    var longitude: Double
    var horizontalAccuracy: CLLocationAccuracy
    var verticalAccuracy: CLLocationAccuracy
}

final class LocationService: NSObject {
    private enum State {
        case none
        case singleLocationRequest  // single request
        case locationUpdates        // continual location updates
    }
    
    // MARK: - Properties
    
    private let locationManager: CLLocationManager
    
    private var lastAcquiredLocation: CLLocation?
    private var lastAcquiredPlacemark: CLPlacemark?
    
    private var locationOnceCompletions: [LocationCompletion] = []
    private var placemarkOnceCompletions: [PlacemarkCompletion] = []
    
    private var locationSubscribers: [ObjectIdentifier: LocationCompletion] = [:]
    private var placemarkSubscribers: [ObjectIdentifier: PlacemarkCompletion] = [:]
    
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
        return self.isAuthorized || authStatus == .notDetermined
    }
    
    var isAuthorized: Bool {
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() && (authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse)
    }
    
    
    // MARK: - Init
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
    
    
    // MARK: - Public API
    
    func start() {
        self.state = .locationUpdates
    }
    
    func stop() {
        self.state = .none
    }
    
    // MARK: Last Received
    
    func lastReceivedLocation() -> Location? {
        if let lastLocation = lastAcquiredLocation {
            return Location(from: lastLocation)
        }
        return nil
    }
    
    func lastReceivedPlacemark() -> CLPlacemark? {
        return lastAcquiredPlacemark
    }
    
    // MARK: Location
    
    func addSubscriberForLocationUpdates(_ subscriber: LocationSubscriber, completion: @escaping LocationCompletion) {
        let identifier = ObjectIdentifier(subscriber)
        locationSubscribers[identifier] = completion
        state = .locationUpdates
    }
    
    func getCurrentLocation(completion: @escaping LocationCompletion) {
        locationOnceCompletions.append(completion)
        state = .singleLocationRequest
    }
    
    // MARK: Placemark
    
    func addSubscriberForPlacemarkUpdates(_ subscriber: LocationSubscriber, completion: @escaping PlacemarkCompletion) {
        let identifier = ObjectIdentifier(subscriber)
        placemarkSubscribers[identifier] = completion
        state = .locationUpdates
    }
    
    func getCurrentPlacemark(completion: @escaping PlacemarkCompletion) {
        placemarkOnceCompletions.append(completion)
        state = .singleLocationRequest
    }
    
    func removeSubscriber(_ subscriber: LocationSubscriber) {
        let identifier = ObjectIdentifier(subscriber)
        locationSubscribers[identifier] = nil
        placemarkSubscribers[identifier] = nil
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            debugPrint("Access to location not determined", inCase: .locationUpdates)
        case .restricted, .denied:
            debugPrint("Access to location denied", inCase: .locationUpdates)
            self.state = .none
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("Access to location granted", inCase: .locationUpdates)
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
        guard let currentLocation = locations.last else { return }
        
        self.lastAcquiredLocation = currentLocation
        
        handleReceivedLocationResult(.success(Location(from: currentLocation)))

        reverseGeocodeLocation(currentLocation) { [weak self] result in
            switch result {
            case let .success(placemark):
                self?.lastAcquiredPlacemark = placemark
            case let .failure(error):
                debugPrint("Did receive error while try to get placemark for location: \(currentLocation), error: \(error)", inCase: .locationUpdates)
            }
            self?.handleReceivedPlacemarkResult(result)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleReceivedLocationResult(.failure(error))
        handleReceivedPlacemarkResult(.failure(error))
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
    
    private func handleReceivedLocationResult(_ result: Result<Location>) {
        for completion in locationSubscribers.values {
            completion(result)
        }
        for completion in locationOnceCompletions {
            completion(result)
        }
        locationOnceCompletions.removeAll()
    }
    
    private func handleReceivedPlacemarkResult(_ result: Result<CLPlacemark>) {
        for completion in placemarkSubscribers.values {
            completion(result)
        }
        for completion in placemarkOnceCompletions {
            completion(result)
        }
        placemarkOnceCompletions.removeAll()
    }
}

// MARK: - Location

private extension Location {
    init(from location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.horizontalAccuracy = location.horizontalAccuracy
        self.verticalAccuracy = location.verticalAccuracy
    }
}
