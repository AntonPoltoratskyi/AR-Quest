//
//  SideMenuContainerInteractor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol SideMenuContainerInteractorInput: class {
}

protocol SideMenuContainerInteractorOutput: class {
}

final class SideMenuContainerInteractor: Interactor, SideMenuContainerInteractorInput {
    typealias Output = SideMenuContainerInteractorOutput
    weak var output: SideMenuContainerInteractorOutput!
}
