//
//  WeakReference.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 30.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

class WeakReference<T: AnyObject> {
    weak var ref: T?
    
    init(_ ref: T) {
        self.ref = ref
    }
}

final class SubscriberContainer<Handler>: WeakReference<AnyObject> {
    
    var handler: Handler?
    
    init(ref: AnyObject, handler: Handler) {
        self.handler = handler
        super.init(ref)
    }
}
