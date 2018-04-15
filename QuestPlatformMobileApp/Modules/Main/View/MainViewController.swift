//
//  MainViewController.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 08.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import GuillotineMenu

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
    
    private(set) lazy var menuAnimator: GuillotineTransitionAnimation = {
        let animator = GuillotineTransitionAnimation()
        animator.animationDuration = 0.2
        animator.supportView = contentView.navigationView
        return animator
    }()
    
    
    // MARK: - Views
    
    private lazy var contentView: MainView = {
        let contentView = MainView()
        contentView.joinButton.addTarget(self, action: #selector(actionJoin(sender:)), for: .touchUpInside)
        contentView.navigationView.setupLeftButton(title: "Q") { [weak self] sender in
            self?.menuAnimator.presentButton = sender
            self?.output?.didClickMenu()
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
            contentView.descriptionLabel.text = "Quests around You"
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func actionJoin(sender: UIButton) {
        output.didClickJoin()
    }
    
    
    // MARK: - Navigation
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .custom
        viewControllerToPresent.transitioningDelegate = self
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    
    func setup(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuAnimator.mode = .presentation
        return menuAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuAnimator.mode = .dismissal
        return menuAnimator
    }
}
