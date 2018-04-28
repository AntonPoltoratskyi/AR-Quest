//
//  QuestViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit

final class QuestViewController: UIViewController, View {
    
    typealias Output = QuestViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: QuestView = {
        let contentView = QuestView()
        return contentView
    }()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.viewDidDisappear()
    }
}

// MARK: - QuestViewInput
extension QuestViewController: QuestViewInput {
    
    var sceneView: ARSCNView {
        return contentView.sceneView
    }
    
    func showMessage(_ message: String) {
        contentView.debugLabel.text = message
    }
}
