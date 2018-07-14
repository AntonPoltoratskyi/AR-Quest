//
//  Presenter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol Presenter: class {
    associatedtype View
    associatedtype Interactor
    associatedtype Router
    
    var view: View! { get set }
    var interactor: Interactor! { get set }
    var router: Router! { get set }
}
