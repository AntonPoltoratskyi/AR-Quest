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
        contentView.addSubview(label)
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
    }
}
