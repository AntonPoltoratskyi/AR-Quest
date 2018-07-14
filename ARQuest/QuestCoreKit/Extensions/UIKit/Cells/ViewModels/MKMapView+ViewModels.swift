//
//  MKMapView+ViewModels.swift
//  Components
//
//  Created by Anton Poltoratskyi on 29.01.18.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import MapKit

public typealias MapAnnotationModel = MKAnnotation & AnyCellViewModel

extension MKMapView {
    
    open func dequeueReusableAnnotationView(withModel viewModel: MapAnnotationModel) -> MKAnnotationView {
        let identifier = type(of: viewModel).uniqueIdentifier
        let annotationView = dequeueReusableAnnotationView(withIdentifier: identifier, for: viewModel)
        viewModel.setup(cell: annotationView)
        return annotationView
    }
    
    open func register<T: CellViewModel & MKAnnotation>(viewModel: T.Type) where T.Cell: MKAnnotationView {
        register(T.Cell.self, forAnnotationViewWithReuseIdentifier: T.uniqueIdentifier)
    }
}
