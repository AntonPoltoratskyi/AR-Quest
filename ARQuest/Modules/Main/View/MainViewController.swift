//
//  MainViewController.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

struct MainViewModel {
    static let initial = MainViewModel(state: .loading)
    
    enum State {
        case loading
        case loaded(nearbyEvents: Int)
    }
    let state: State
}

final class MainViewController: UIViewController, View {
    
    typealias Output = MainViewOutput
    var output: Output!
    
    private var viewModel: MainViewModel = .initial {
        didSet {
            setupState(viewModel.state)
        }
    }
    
    
    // MARK: - Views
    
    private lazy var contentView: MainView = {
        let contentView = MainView()
        contentView.joinButton.addTarget(self, action: #selector(actionJoin(sender:)), for: .touchUpInside)
        contentView.navigationView.setupLeftButton(icon: #imageLiteral(resourceName: "ic_burger")) { [weak self] sender in
            self?.output?.toggleMenu()
        }
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
    
    
    // MARK: - UI Layout
    
    private func setupState(_ state: MainViewModel.State) {
        switch state {
        case .loading:
            contentView.countLabel.text = ""
            contentView.descriptionLabel.text = "Loading ..."
        case let .loaded(nearbyEventsCount):
            contentView.countLabel.text = String(nearbyEventsCount)
            contentView.descriptionLabel.text = """
            quests
            are waiting for
            You
            """
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func actionJoin(sender: UIButton) {
        output.didClickJoin()
    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    
    func setup(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}
