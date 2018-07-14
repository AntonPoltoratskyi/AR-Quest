//
//  UITableView+HeaderFooter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

extension UITableView {
    
    open func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>(ofType type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.uniqueIdentifier) as! T
    }
    
    open func register<T: UITableViewHeaderFooterView & Reusable>(headerFooter: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.uniqueIdentifier)
    }
}
