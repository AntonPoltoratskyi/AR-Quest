//
//  NavigationService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import MapKit
import CoreLocation

final class NavigationService: NSObject {
    
    weak var delegate: NavigationServiceDelegate?
    
    private let locationManager = CLLocationManager()
    
    private let queue = DispatchQueue.queue(for: NavigationService.self, qos: .default, attributes: .concurrent)
    
    private var coordinateRequestCache: [Coordinate: CLPlacemark] = [:]
    
    private var shouldStartUpdating = false
    
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    // MARK: - Actions
    
    func startLocationTracking() {
        shouldStartUpdating = true
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            delegate?.navigationService(self, didReceiveNoAuthorization: CLLocationManager.authorizationStatus())
        }
    }
    
    func requestPlaces(for coordinates: Coordinate, callback: @escaping (_ mark: CLPlacemark?, _ error: Error?) -> Void) {
        if let cachedValue = coordinateRequestCache[coordinates] {
            callback(cachedValue, nil); return
        }
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        queue.async {
            geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
                if let placemark = placeMarks?.first {
                    self.coordinateRequestCache[coordinates] = placemark
                }
                callback(placeMarks?.first, error)
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension NavigationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.navigationService(self, didUpdateLocations: locations)
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else { return }
        
        delegate?.navigationService(self, didUpdateHeading: newHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            guard shouldStartUpdating else {
                return
            }
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.navigationService(self, didFailWithError: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        guard let error = error else { return }
        delegate?.navigationService(self, didFailWithError: error)
    }
}
