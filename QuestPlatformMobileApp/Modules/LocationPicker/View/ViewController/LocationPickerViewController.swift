//
//  LocationPickerViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import MapKit

final class LocationPickerViewController: UIViewController, View {
    
    typealias Output = LocationPickerViewOutput
    var output: Output!
    
    private var selectedLocation: LocationAnnotation?
    
    
    // MARK: - Views
    
    private lazy var contentView: LocationPickerView = {
        let contentView = LocationPickerView()
        
        let navigationView = contentView.navigationView
        navigationView.setupLeftButton(title: "Cancel") { [unowned self] _ in
            self.actionCancel()
        }
        navigationView.setupRightButton(title: "Done") { [unowned self] _ in
            self.actionDone()
        }
        
        let mapView = contentView.mapView
        mapView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionMapViewTapped(recognizer:)))
        tap.delegate = self
        mapView.addGestureRecognizer(tap)
        
        mapView.register(viewModel: LocationAnnotation.self)
        
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
    
    
    // MARK: Actions
    
    @objc private func actionMapViewTapped(recognizer: UITapGestureRecognizer) {
        let mapView = contentView.mapView
        let point = recognizer.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let location = LocationAnnotation(coordinate: coordinate, title: "Destination")
        mapView.addAnnotation(location)
        
        output.didSelectCoordinate(coordinate)
    }
    
    private func actionDone() {
        output.didClickDone()
    }
    
    private func actionCancel() {
        output.didClickCancel()
    }
}

// MARK: - MKMapViewDelegate
extension LocationPickerViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        return (annotation as? MapAnnotationModel).map {
            mapView.dequeueReusableAnnotationView(withModel: $0)
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for annotationView in views {
            
            guard let coordinate = annotationView.annotation?.coordinate else { continue }
            
            let point = MKMapPointForCoordinate(coordinate)
            
            guard MKMapRectContainsPoint(mapView.visibleMapRect, point) else { continue }
            
            let endAnimationFrame = annotationView.frame
            
            annotationView.frame = CGRect(
                x: annotationView.frame.origin.x,
                y: annotationView.frame.origin.y - self.view.frame.size.height,
                width: annotationView.frame.size.width,
                height: annotationView.frame.size.height
            )
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.04 * Double(views.index(of: annotationView)!),
                           options: [.curveLinear],
                           animations: {
                            annotationView.frame = endAnimationFrame
            }, completion: { isFinished in
                
                UIView.animate(withDuration: 0.05, animations: {
                    annotationView.transform = CGAffineTransform(scaleX: 1, y: 0.8)
                    
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        annotationView.transform = .identity
                    }
                })
            })
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension LocationPickerViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let recognizer = otherGestureRecognizer as? UITapGestureRecognizer {
            return recognizer.numberOfTapsRequired > 1 || recognizer.numberOfTouchesRequired > 1
        }
        return false
    }
}

// MARK: - LocationPickerViewInput
extension LocationPickerViewController: LocationPickerViewInput {
    
}
