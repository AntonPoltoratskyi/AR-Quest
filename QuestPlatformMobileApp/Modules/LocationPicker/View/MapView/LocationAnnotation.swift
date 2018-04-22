//
//  LocationAnnotation.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import MapKit

final class LocationAnnotation: NSObject, MKAnnotation, CellViewModel {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    func setup(cell: MKMarkerAnnotationView) {
        cell.isDraggable = true
    }
}
