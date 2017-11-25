//
//  UIView+NSLayoutConstraint.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/18/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var leading: NSLayoutConstraint? {
        return constraint(for: .leading)
    }
    public var trailing: NSLayoutConstraint? {
        return constraint(for: .trailing)
    }
    
    func activateConstraint(to item: UIView, attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        if let constraint = self.constraint(to: item, attribute: attribute) {
            return constraint
        } else {
            let constraint = NSLayoutConstraint.constraint(forBinding: self, to: item, attribute: attribute)
            NSLayoutConstraint.activate([constraint])
            return constraint
        }
    }
    
    func constraint(to item: UIView, attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        
        for constraint in superview.constraints {
            guard constraint.firstAttribute == attribute, constraint.secondAttribute == attribute else {
                continue
            }
            if let firstView = constraint.firstItem as? UIView,
                let secondView = constraint.secondItem as? UIView,
                (firstView === self && secondView === item) || (secondView === self && firstView === item){
                return constraint
            }
        }
        return nil
    }
    
    func constraint(for attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        guard let superview = superview else { return nil }
        
        for constraint in superview.constraints {
            guard constraint.firstAttribute == attribute && constraint.secondAttribute == attribute else {
                continue
            }
            if let view = constraint.firstItem as? UIView, view == self {
                return constraint
            } else if let view = constraint.secondItem as? UIView, view == self {
                return constraint
            }
        }
        return nil
    }
    
    public func removeParentConstraints(with attributes: Set<NSLayoutAttribute>) {
        var superview = self.superview
        while superview != nil {
            for constraint in superview!.constraints {
                guard
                    constraint.firstItem === self || constraint.secondItem === self,
                    attributes.contains(constraint.firstAttribute) || attributes.contains(constraint.secondAttribute) else {
                        continue
                }
                superview?.removeConstraint(constraint)
            }
            superview = superview?.superview
        }
    }
}
