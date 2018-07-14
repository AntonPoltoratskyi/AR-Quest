//
//  Interactor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol Interactor: class {
    associatedtype Output
    var output: Output! { get set }
}
