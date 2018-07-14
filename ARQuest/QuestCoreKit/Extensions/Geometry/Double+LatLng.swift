//
//  Double+LatLng.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Double {
    
    var metersToLatitude: Double {
        return self / 6_373_000
    }
    
    var metersToLongitude: Double {
        return self / 5_602_900
    }
}
