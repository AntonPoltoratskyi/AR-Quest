//
//  LocationPickerViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class LocationPickerViewController: UIViewController, View {
    
    typealias Output = LocationPickerViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: LocationPickerView = {
        let contentView = LocationPickerView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - LocationPickerViewInput
extension LocationPickerViewController: LocationPickerViewInput {
    
}
