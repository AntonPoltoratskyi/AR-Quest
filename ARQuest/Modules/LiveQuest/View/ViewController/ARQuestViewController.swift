//
//  ARQuestViewController.swift
//  ARQuest
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
        output.didClickNextButton()
    }
}

// MARK: - ARQuestViewInput
extension ARQuestViewController: ARQuestViewInput {
    
    var sceneView: ARSCNView {
        return contentView.sceneView
    }
    
    func showDebugMessage(_ message: String) {
    }
    
    func showTaskName(_ name: String) {
        contentView.showTaskName(name)
    }
    
    func showTextPopup(_ text: String) {
        
        let popup = ARQuestPopupViewController()
        popup.text = text
        popup.closeHandler = { vc in
            vc.dismiss(animated: true) {
                self.output.didHideTextPopup()
            }
        }
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    func showDistance(_ distance: Distance) {
        contentView.showDistance(distance)
    }
    
    func showLocationSearch() {
        contentView.showLocationSearch()
    }
    
    func enableNextAction() {
        contentView.nextButton.isEnabled = true
    }
    
    func disableNextButton() {
        contentView.nextButton.isEnabled = false
    }
    
    func showSceneState(_ state: ARSceneViewState) {
        contentView.stateLabel.text = state.hint
    }
}
