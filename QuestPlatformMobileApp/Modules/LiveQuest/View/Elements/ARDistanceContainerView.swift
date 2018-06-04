//
//  ARDistanceContainerView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.06.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

final class ARDistanceContainerView: UIView {
    
    enum State {
        case loading
        case distance(Distance)
    }
    
    var state: State = .loading {
        didSet {
            setup(state)
        }
    }
    
    private let formatter: LengthFormatter = {
        let formatter = LengthFormatter()
        return formatter
    }()
    
    
    // MARK: - Views
    
    private(set) lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        return activityIndicator
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
        distanceLabel.snp.makeConstraints { maker in
            maker.horizontalInset(24)
            maker.centerY.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(16)
        }
    }
    
    private func setup(_ state: State) {
        switch state {
        case .loading:
            distanceLabel.text = "Search Location ..."
            activityIndicator.startAnimating()
        case let .distance(distance):
            distanceLabel.text = "Go \(formatter.string(fromMeters: distance))"
            activityIndicator.stopAnimating()
        }
    }
}
