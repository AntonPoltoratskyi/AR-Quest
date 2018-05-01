//
//  CLLocationCoordinate2D+Extensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation
import MapKit

extension Coordinate {
    
    /// In radians
    func bearingAngle(to coordinate: Coordinate) -> Double {
        let destLat = coordinate.latitude.degreesToRadians
        let destLng = coordinate.longitude.degreesToRadians
        
        let selfLat = latitude.degreesToRadians
        let selfLng = longitude.degreesToRadians
        
        let a = sin(destLng - selfLng) * cos(destLat)
        let b = cos(selfLat) * sin(destLat) - sin(selfLat) * cos(destLat) * cos(destLng - selfLng)
        
        return atan2(a, b)
    }
    
    /// In degrees
    func directionAngle(to coordinate: Coordinate) -> Direction {
        return bearingAngle(to: coordinate).radiansToDegrees
    }
    
    func distance(to coordinate: Coordinate) -> Distance {
        return clLocation.distance(from: coordinate.clLocation)
    }
    
    func coordinate(with bearingAngle: Double, distance: Double) -> Coordinate {
        let latDistance = distance.metersToLatitude
        let lngDistance = distance.metersToLongitude
        
        let lat1 = latitude.degreesToRadians
        let lng1 = longitude.degreesToRadians
        
        let lat2 = asin(sin(lat1) * cos(latDistance) + cos(lat1) * sin(latDistance) * cos(bearingAngle))
        let lng2 = lng1 + atan2(sin(bearingAngle) * sin(lngDistance) * cos(lat1), cos(lngDistance) - sin(lat1) * sin(lat2))
        
        return Coordinate(latitude: lat2.radiansToDegrees, longitude: lng2.radiansToDegrees)
    }
}

extension Coordinate {
    var clLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Hashable

extension Coordinate: Hashable {
    public var hashValue: Int {
        return Int(latitude * 1000) + Int(longitude * 1000)
    }
    
    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return abs(lhs.latitude - rhs.latitude) <= 0.001 && abs(lhs.longitude - rhs.longitude) <= 0.001
    }
}

// MARK: - Placemark

extension Coordinate {
    var placemark: MKPlacemark {
        return MKPlacemark(coordinate: self)
    }
}
