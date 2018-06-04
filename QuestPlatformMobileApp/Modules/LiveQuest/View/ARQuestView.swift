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
    
    private let formatter: LengthFormatter = {
        let formatter = LengthFormatter()
        return formatter
    }()
    
    
    // MARK: - Views
    
    override var isNavigationViewVisible: Bool {
        return false
    }
    
    private(set) lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        contentView.addSubview(sceneView)
        return sceneView
    }()
    
    private(set) lazy var debugLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var popupLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        return label
    }()
    
    private(set) lazy var nextButton: QuestButton = {
        let button = QuestButton()
        button.setTitle("Next", for: .normal)
        contentView.addSubview(button)
        return button
    }()
    
    private(set) lazy var stateView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 6
        
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
        
        debugLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(16)
            maker.horizontalInset(16)
        }
        
        popupLabel.snp.makeConstraints { maker in
            maker.top.equalTo(debugLabel.snp.bottom).offset(16)
            maker.horizontalInset(16)
        }
        
        distanceLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(nextButton.snp.top).offset(-16)
            maker.horizontalInset(16)
        }
        
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
        
        nextButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(16)
            maker.horizontalInset(16)
            maker.buttonHeight()
        }
    }
    
    func showDistance(_ distance: Distance) {
        distanceLabel.text = "Go \(formatter.string(fromMeters: distance))"
    }
}
