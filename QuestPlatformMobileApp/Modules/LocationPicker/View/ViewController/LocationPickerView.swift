//
//  LocationPickerView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

final class LocationPickerView: BaseView {

    override var title: String? {
        return "Select Location"
    }
    
    // MARK: - Views

    private(set) lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        addSubview(mapView)
        return mapView
    }()

    
    // MARK: - Setup
    
    override func setup() {
        super.setup()

        mapView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
        }
    }
}
