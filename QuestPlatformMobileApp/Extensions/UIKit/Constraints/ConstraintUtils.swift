//
//  ConstraintUtils.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/18/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    public static func constraints(forBinding view: UIView, to parentView: UIView) -> [NSLayoutConstraint] {
        return [leading, trailing, top, bottom].map { return $0(parentView, view, 0.0) }
    }
    
    public static func leading(forBinding view: UIView, to parentView: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(forBinding: view, to: parentView, attribute: .leading)
    }
    
    public static func trailing(forBinding view: UIView, to parentView: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(forBinding: view, to: parentView, attribute: .trailing)
    }
    
    public static func top(forBinding view: UIView, to parentView: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(forBinding: view, to: parentView, attribute: .top)
    }
    
    public static func bottom(forBinding view: UIView, to parentView: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(forBinding: view, to: parentView, attribute: .bottom)
    }
    
    public static func width(for view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(for: view,
                               attribute: .width,
                               relation: .equal,
                               constant: constant)
    }
    
    public static func height(for view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(for: view,
                               attribute: .height,
                               relation: .equal,
                               constant: constant)
    }
    
    public static func constraint(for view: UIView, attribute: NSLayoutAttribute, relation: NSLayoutRelation = .equal, constant: CGFloat, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: attribute,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
    
    public static func constraint(forBinding view: UIView, to parentView: UIView, attribute: NSLayoutAttribute, relation: NSLayoutRelation = .equal, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: attribute,
                                  relatedBy: relation,
                                  toItem: parentView,
                                  attribute: attribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
}
