//
//  QuestView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit
import SnapKit

final class QuestView: BaseView {
    
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
        
        nextButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(16)
            maker.horizontalInset(16)
            maker.buttonHeight()
        }
    }
    
    func showDistance(_ distance: Distance) {
        distanceLabel.text = "Distance: \(formatter.string(fromMeters: distance))"
    }
}
