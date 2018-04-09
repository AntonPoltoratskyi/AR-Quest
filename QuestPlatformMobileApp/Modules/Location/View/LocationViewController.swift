//
//  LocationViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

protocol LocationViewInput: class {
}

protocol LocationViewOutput: class {
}

final class LocationViewController: UIViewController, View {
    
    typealias Output = LocationViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    
    // MARK: - Views
    
    private lazy var contentView: LocationView = {
        let contentView = LocationView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeController.addGesture()
    }
}

// MARK: - LocationViewInput
extension LocationViewController: LocationViewInput {
    
}
