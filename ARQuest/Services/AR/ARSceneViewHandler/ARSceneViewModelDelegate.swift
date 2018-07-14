//
//  ARSceneViewModelDelegate.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

public protocol ARSceneViewModelDelegate: class {
    func sceneViewModel(_ sceneModel: ARSceneViewModel, didUpdateState newState: ARSceneViewState)
}
