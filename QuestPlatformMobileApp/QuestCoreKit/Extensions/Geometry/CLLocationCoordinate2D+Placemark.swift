//
//  CLLocationCoordinate2D+Placemark.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D {
    
    var placemark: MKPlacemark {
        return MKPlacemark(coordinate: self)
    }
}
