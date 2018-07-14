//
//  SlideAnimatedTransitioning.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 09.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class SlideAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration  = 0.3
    let defaultViewWidth: CGFloat = 320
    var viewWidth: CGFloat?
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view else { return }
        guard let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        
        if viewWidth == nil { viewWidth = fromView.bounds.width }
        let startX: CGFloat = fromView.bounds.width
        
        let startFrame = CGRect(x: startX,
                                y: 0,
                                width: viewWidth ?? defaultViewWidth,
                                height: fromView.bounds.height)
        let transformedStartFrame = transitionContext.containerView.convert(startFrame, to: fromView)
        
        let endX: CGFloat = fromView.bounds.width - (viewWidth ?? 0)
        let endFrame = CGRect(x: endX,
                              y: 0,
                              width: viewWidth ?? defaultViewWidth,
                              height: fromView.bounds.height)
        let transformedEndFrame = transitionContext.containerView.convert(endFrame, to: fromView)
        
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        
        toView.frame = CGRect(x: transformedEndFrame.origin.x - 100,
                              y: 0,
                              width: transformedEndFrame.width,
                              height: transformedEndFrame.height)
        
        fromView.layer.shadowRadius = 5.0
        fromView.layer.shadowOpacity = 1.0
        toView.layer.opacity = 0.9
        
        UIView.animate(withDuration: self.animationDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        
                        fromView.frame = transformedStartFrame
                        toView.frame = transformedEndFrame
                        
                        toView.layer.opacity = 1.0
                        fromView.layer.shadowOpacity = 0.1
                        
        }, completion: { (finished) in
            
            toView.layer.opacity = 1.0
            toView.layer.shadowOpacity = 0
            fromView.layer.opacity = 1.0
            fromView.layer.shadowOpacity = 0
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animationDuration
    }
}
