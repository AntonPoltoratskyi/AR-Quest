//
//  ARQuestNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit

class ARQuestNode: SCNNode {
    
    var identifier: String = ""
    
    
    // MARK: - Init
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    func setup() {
        
    }
}
