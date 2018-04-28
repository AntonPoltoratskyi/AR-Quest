//
//  ARSceneViewHandlerDelegate.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

public protocol ARSceneViewHandlerDelegate: class {
    func sceneViewHandler(_ handler: ARSceneViewHandler, didUpdateState newState: ARSceneViewState)
}
