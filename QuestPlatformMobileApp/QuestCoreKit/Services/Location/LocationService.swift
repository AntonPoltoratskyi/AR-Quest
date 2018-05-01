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
        case locationUpdates        // continual location updates
    }
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    private var lastAcquiredLocation: CLLocation?
    private var lastAcquiredPlacemark: CLPlacemark?
    
    private var authorizationStatusSubscribers: [SubscriberContainer<LocationAuthorizationStatusHandler>] = []
    private var locationSubscribers: [SubscriberContainer<LocationHandler>] = []
    private var headingSubscribers: [SubscriberContainer<HeadingHandler>] = []
    private var placemarkSubscribers: [SubscriberContainer<PlacemarkHandler>] = []
    private var errorSubscribers: [SubscriberContainer<LocationErrorHandler>] = []
    
    private var state: State = .none {
        didSet {
            guard state != oldValue else {
                return
            }
            switch state {
            case .none:
                locationManager.stopUpdatingLocation()
                locationManager.stopUpdatingHeading()
            case .locationUpdates:
                if isAuthorized {
                    locationManager.startUpdatingLocation()
                    locationManager.startUpdatingHeading()
                } else {
                    locationManager.requestAlwaysAuthorization()
                }
            }
        }
    }
    
    var isGeocodingEnabled: Bool = false
    
    var isLocationUpdatesAvailable: Bool {
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        return isAuthorized || authStatus == .notDetermined
    }
    
    var isAuthorized: Bool {
        let status = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() && (status == .authorizedAlways || status == .authorizedWhenInUse)
    }
    
    
    // MARK: - Init
    
    static let shared = LocationService()
    
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.showsBackgroundLocationIndicator = true
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
        if let index = authorizationStatusSubscribers.index(where: { $0.ref === subscriber }) {
            authorizationStatusSubscribers.remove(at: index)
        }
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        authorizationStatusSubscribers.append(container)
        
        if !isAuthorized {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func observeLocationUpdates(_ subscriber: LocationSubscriber, handler: @escaping LocationHandler) {
        if let index = locationSubscribers.index(where: { $0.ref === subscriber }) {
            locationSubscribers.remove(at: index)
        }
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        locationSubscribers.append(container)
        
        if let lastLocation = lastAcquiredLocation {
            handler(lastLocation)
        }
    }
    
    func observeHeadingUpdates(_ subscriber: LocationSubscriber, handler: @escaping HeadingHandler) {
        if let index = headingSubscribers.index(where: { $0.ref === subscriber }) {
            headingSubscribers.remove(at: index)
        }
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        headingSubscribers.append(container)
    }

    func observePlacemarkUpdates(_ subscriber: LocationSubscriber, handler: @escaping PlacemarkHandler) {
        if let index = placemarkSubscribers.index(where: { $0.ref === subscriber }) {
            placemarkSubscribers.remove(at: index)
        }
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        placemarkSubscribers.append(container)
        
        if let lastPlacemark = lastAcquiredPlacemark {
            handler(lastPlacemark)
        }
    }
    
    func observeErrors(_ subscriber: LocationSubscriber, handler: @escaping LocationErrorHandler) {
        if let index = errorSubscribers.index(where: { $0.ref === subscriber }) {
            errorSubscribers.remove(at: index)
        }
        let container = SubscriberContainer(ref: subscriber, handler: handler)
        errorSubscribers.append(container)
    }
    
    func removeSubscriber(_ subscriber: LocationSubscriber) {
        authorizationStatusSubscribers = authorizationStatusSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        locationSubscribers = locationSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        headingSubscribers = headingSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        placemarkSubscribers = placemarkSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
        errorSubscribers = errorSubscribers.filter { $0.ref != nil && $0.ref !== subscriber }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleReceivedAuthorizationStatus(status)
        
        switch status {
        case .notDetermined:
            debugPrint("Access to location not determined", inCase: .location)
        case .restricted, .denied:
            debugPrint("Access to location denied", inCase: .location)
            state = .none
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("Access to location granted", inCase: .location)
            // Start updating location only after success authorization
            continueLocationUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        lastAcquiredLocation = currentLocation
        handleReceivedLocation(currentLocation)

        guard isGeocodingEnabled else {
            return
        }
        reverseGeocodeLocation(currentLocation) { [weak self] result in
            switch result {
            case let .success(placemark):
                self?.lastAcquiredPlacemark = placemark
                self?.handleReceivedPlacemark(placemark)
            case let .failure(error):
                debugPrint("Did receive error while try to get placemark for location: \(currentLocation), error: \(error)", inCase: .location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else {
            return
        }
        handleReceivedHeading(newHeading)
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleReceivedError(error)
    }
    
    private func continueLocationUpdates() {
        switch state {
        case .none:
            break
        case .locationUpdates:
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    private func handleReceivedAuthorizationStatus(_ status: CLAuthorizationStatus) {
        for subscriber in authorizationStatusSubscribers {
            subscriber.handler?(status)
        }
    }
    
    private func handleReceivedLocation(_ location: CLLocation) {
        for subscriber in locationSubscribers {
            subscriber.handler?(location)
        }
    }
    
    private func handleReceivedPlacemark(_ placemark: CLPlacemark) {
        for subscriber in placemarkSubscribers {
            subscriber.handler?(placemark)
        }
    }
    
    private func handleReceivedHeading(_ heading: CLHeading) {
        for subscriber in headingSubscribers {
            subscriber.handler?(heading)
        }
    }
    
    private func handleReceivedError(_ error: Error) {
        for subscriber in errorSubscribers {
            subscriber.handler?(error)
        }
    }
}

// MARK: - Geocoding

extension LocationService {
    
    private enum GeocodingResult<T> {
        case success(T)
        case failure(Error)
    }
    
    private func reverseGeocodeLocation(_ location: CLLocation, completion: @escaping (GeocodingResult<CLPlacemark>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                completion(.success(placemark))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
