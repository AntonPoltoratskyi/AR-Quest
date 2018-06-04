//
//  ARQuestViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import ARKit

final class ARQuestViewController: UIViewController, View {
    
    typealias Output = ARQuestViewOutput
    var output: Output!
    
    
    // MARK: - Views
    
    private lazy var contentView: ARQuestView = {
        let contentView = ARQuestView()
        contentView.nextButton.addTarget(self, action: #selector(actionNextButtonTapped(sender:)), for: .touchUpInside)
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
    
    
    // MARK: - Actions
    
    @objc private func actionNextButtonTapped(sender: UIButton) {
        output.didHideTextPopup()
    }
}

// MARK: - ARQuestViewInput
extension ARQuestViewController: ARQuestViewInput {
    
    var sceneView: ARSCNView {
        return contentView.sceneView
    }
    
    func showDebugMessage(_ message: String) {
        // contentView.debugLabel.text = message
    }
    
    func showTextPopup(_ text: String) {
        contentView.popupLabel.text = text
    }
    
    func showDistance(_ distance: Distance) {
        contentView.showDistance(distance)
    }
    
    func enableNextAction() {
        contentView.nextButton.isEnabled = true
    }
    
    func disableNextButton() {
        contentView.nextButton.isEnabled = false
    }
}
