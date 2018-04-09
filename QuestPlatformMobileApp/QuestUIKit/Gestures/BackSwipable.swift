//
//  BackSwipable.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

typealias SwipeCompletion = () -> Void

final class SwipeController: NSObject {
    
    private var transition: UIPercentDrivenInteractiveTransition?
    private var panRecognizer: ClosurePanRecognizer!
    
    private weak var vc: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var originalDelegate: UINavigationControllerDelegate?
    
    private var completion: SwipeCompletion?
    

    // MARK: - Init
    
    init(target: UIViewController, completion: SwipeCompletion? = nil) {
        self.vc = target
        self.completion = completion
    }
    
    
    // MARK: - Gesture
    
    func addGesture() {
        guard shouldHandleSwipe else { return }
        
        panRecognizer = ClosurePanRecognizer()
        panRecognizer.targetAction = { [weak self] in
            guard let recognizer = self?.panRecognizer else { return }
            self?.handlePanGesture(recognizer)
        }
        self.vc?.view.addGestureRecognizer(panRecognizer)
    }
    
    private var shouldHandleSwipe: Bool {
        let count = self.vc?.navigationController?.viewControllers.count ?? 0
        return count > 1
    }
    
    private func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        guard let vc = self.vc else { return }
        
        let percent = max(panGesture.translation(in: vc.view).x, 0) / vc.view.frame.width
        
        switch panGesture.state {
        case .began:
            navigationController = self.vc?.navigationController
            originalDelegate = navigationController?.delegate
            navigationController?.delegate = self
            navigationController?.popViewController(animated: true)
        case .changed:
            transition?.update(percent)
        case .ended:
            let velocity = panGesture.velocity(in: self.vc?.view).x
            
            // Continue if drag more than 25% of screen width or velocity is higher than 1000
            if percent > 0.25 || velocity > 1000 {
                transition?.finish()
            } else {
                transition?.cancel()
                rollback()
            }
        case .cancelled, .failed:
            transition?.cancel()
            rollback()
        default:
            break
        }
        completion?()
    }
    
    private func rollback() {
        if let nav = navigationController, let vc = vc {
            originalDelegate?.navigationController?(nav, didShow: vc, animated: true)
            navigationController = nil
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension SwipeController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideAnimatedTransitioning()
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        navigationController.delegate = originalDelegate
        
        if panRecognizer.state == .began {
            transition = UIPercentDrivenInteractiveTransition()
            transition?.completionCurve = .easeOut
        } else {
            transition = nil
        }
        return transition
    }
}
