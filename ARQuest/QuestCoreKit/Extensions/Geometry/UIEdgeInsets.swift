//
//  UIEdgeInsets.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    public var horizontal: CGFloat {
        return left + right
    }
    public var vertical: CGFloat {
        return top + bottom
    }
}

extension CGRect {
    public func insetBy(edges: UIEdgeInsets) -> CGRect {
        return CGRect(
            x: minX + edges.left,
            y: minY + edges.top,
            width: width - edges.horizontal,
            height: height - edges.vertical
        )
    }
}
