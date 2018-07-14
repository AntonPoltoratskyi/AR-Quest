//
//  Collection.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 01.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Collection {
    
    func next(after predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        var idx: Index? = nil
        for (i, element) in zip(indices, self) {
            if predicate(element) {
                idx = i
                break
            }
        }
        
        if let index = idx,
            let resultIndex = self.index(index, offsetBy: 1, limitedBy: self.endIndex),
            resultIndex != endIndex {
            
            return self[resultIndex]
        }
        return nil
    }
}

extension Collection where Iterator.Element: Equatable {
    
    func next(after target: Iterator.Element) -> Iterator.Element? {
        return next(after: { $0 == target })
    }
}
