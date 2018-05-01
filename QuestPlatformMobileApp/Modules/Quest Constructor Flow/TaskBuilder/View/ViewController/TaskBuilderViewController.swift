//
//  TaskBuilderViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import MapKit

final class TaskBuilderViewController: UIViewController, View, KeyboardInteracting {
    
    typealias Output = TaskBuilderViewOutput
    var output: Output!
    
    private lazy var swipeController: SwipeController = {
        return SwipeController(target: self)
    }()
    
    private var snapshotter: MKMapSnapshotter?
    
    // MARK: - Views
    
    var scrollView: UIScrollView! {
        return contentView.scrollView
    }
    
    var keyboardInputViews: [KeyboardInputView] {
        return [contentView.titleField]
    }
    
    private lazy var contentView: TaskBuilderView = {
        let contentView = TaskBuilderView()
        contentView.titleField.delegate = self
        
        contentView.doneButton
            .addTarget(self, action: #selector(actionDoneButtonTapped(sender:)), for: .touchUpInside)
        contentView.locationFormView.selectButton
            .addTarget(self, action: #selector(actionSelectLocationButtonTapped(sender:)), for: .touchUpInside)
        
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
    
    
    // MARK: - Actions
    
    @objc private func actionDoneButtonTapped(sender: UIButton) {
        let title = contentView.titleField.text
        var text: String?
        if !contentView.textFormView.isHidden {
            text = contentView.textFormView.textView.text
        }
        output.didTapDone(title: title, text: text)
    }
    
    @objc private func actionSelectLocationButtonTapped(sender: UIButton) {
        output.didTapSelectLocation()
    }
}

// MARK: - TaskBuilderViewInput
extension TaskBuilderViewController: TaskBuilderViewInput {
    
    func setupSelectedLocation(_ coordinate: Coordinate) {
        let options = MKMapSnapshotOptions()
        
        let radius = 500.0
        
        options.region = MKCoordinateRegionMakeWithDistance(coordinate, radius, radius)
        options.showsPointsOfInterest = true
        options.showsBuildings = true
        options.size = contentView.locationFormView.bounds.size
        
        contentView.locationFormView.startLoading()
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { [weak self] snapshot, error in
            guard let `self` = self else {
                return
            }
            defer { self.contentView.locationFormView.stopLoading() }
            
            if let snapshot = snapshot {
                self.contentView.locationFormView.setupLocationImage(snapshot.image)
            }
        }
        
        self.snapshotter = snapshotter
    }
}

// MARK: - UITextFieldDelegate
extension TaskBuilderViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleNextInput(textField)
        return true
    }
}
