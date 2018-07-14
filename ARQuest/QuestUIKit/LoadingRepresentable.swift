//
//  LoadingRepresentable.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.06.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoadingRepresentable: class {
    func didStartLoading()
    func didFinishLoading()
}

extension LoadingRepresentable {
    
    func didStartLoading() {
        guard !NVActivityIndicatorPresenter.sharedInstance.isAnimating else {
            return
        }
        let activityData = ActivityData(message: "Loading",
                                             messageFont: UIFont.appFont(ofSize: 20, weight: .medium),
                                             type: .ballTrianglePath,
                                             color: .white,
                                             minimumDisplayTime: 500,
                                             textColor: .white)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func didFinishLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
