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

protocol LocationPickerViewDelegate: class {
    func locationPickerViewDidCancel(_ locationPickerView: LocationPickerView)
    func locationPickerViewDidSelectLocation(_ locationPickerView: LocationPickerView)
}

final class LocationPickerView: UIView {
    
    weak var delegate: LocationPickerViewDelegate?
    
    
    // MARK: - Views
    
    private(set) lazy var navigationView: QuestNavigationView = {
        let navigationView = QuestNavigationView()
        navigationView.title = "Location"
        navigationView.setupLeftButton(title: "Cancel") { [unowned self] _ in
            self.delegate?.locationPickerViewDidCancel(self)
        }
        navigationView.setupRightButton(title: "Done") { [unowned self] _ in
            self.delegate?.locationPickerViewDidSelectLocation(self)
        }
        addSubview(navigationView)
        return navigationView
    }()
    
    private(set) lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        addSubview(mapView)
        return mapView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        
        navigationView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
        }
    }
}
