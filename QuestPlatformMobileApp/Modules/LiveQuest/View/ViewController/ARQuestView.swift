//
//  ARQuestView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit
import SnapKit

final class ARQuestView: BaseView {
    
    // MARK: - Views
    
    override var isNavigationViewVisible: Bool {
        return false
    }
    
    private(set) lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        contentView.addSubview(sceneView)
        return sceneView
    }()

    private(set) lazy var nextButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Next", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    // MARK: Distance
    
    private lazy var distanceView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 8
        
        contentView.addSubview(visualEffectView)
        
        return visualEffectView
    }()
    
    private lazy var distanceContentView: ARDistanceContainerView = {
        let distanceContentView = ARDistanceContainerView()
        distanceView.contentView.addSubview(distanceContentView)
        return distanceContentView
    }()
    
    // MARK: State
    
    private lazy var stateView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 8
        
        contentView.addSubview(visualEffectView)
        
        return visualEffectView
    }()
    
    private(set) lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        stateView.contentView.addSubview(label)
        return label
    }()
    

    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        sceneView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        setupDistanceContainer()
        setupStateContainer()
        
        nextButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(16)
            maker.horizontalInset(16)
            maker.buttonHeight()
        }
    }
    
    private func setupDistanceContainer() {
        distanceView.snp.makeConstraints { maker in
            maker.bottom.equalTo(nextButton.snp.top).offset(-16)
            maker.horizontalInset(16)
            maker.height.equalTo(48)
        }
        
        distanceContentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    private func setupStateContainer() {
        stateView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(16)
            maker.horizontalInset(16)
            maker.height.greaterThanOrEqualTo(48)
        }
        
        stateLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(24)
            maker.top.greaterThanOrEqualToSuperview().offset(8)
            maker.bottom.lessThanOrEqualToSuperview().offset(-8)
            maker.centerY.equalToSuperview()
        }
    }
    
    func showDistance(_ distance: Distance) {
        distanceContentView.state = .distance(distance)
    }

    func showLocationSearch() {
        distanceContentView.state = .loading
    }
}
