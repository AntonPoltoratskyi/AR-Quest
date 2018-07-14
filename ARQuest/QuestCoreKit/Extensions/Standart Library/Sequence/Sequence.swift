//
//  Sequence.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 11/9/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Sequence {
    func last(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        return try self.reversed().first(where: predicate)
    }
}

extension BidirectionalCollection {
    
    /// Override Sequence method to increase performance
    func last(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        return try self.reversed().first(where: predicate)
    }
}
