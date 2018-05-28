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
    
    func angle(to coordinate: Coordinate) -> Radians {
        let destLat = coordinate.latitude.degreesToRadians
        let destLng = coordinate.longitude.degreesToRadians
        
        let selfLat = latitude.degreesToRadians
        let selfLng = longitude.degreesToRadians
        
        let a = sin(destLng - selfLng) * cos(destLat)
        let b = cos(selfLat) * sin(destLat) - sin(selfLat) * cos(destLat) * cos(destLng - selfLng)
        
        return atan2(a, b)
    }

    func distance(to coordinate: Coordinate) -> Distance {
        return clLocation.distance(from: coordinate.clLocation)
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
