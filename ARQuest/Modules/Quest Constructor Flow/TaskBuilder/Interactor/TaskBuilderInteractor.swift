//
//  TaskBuilderInteractor.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 23.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

final class TaskBuilderInteractor: Interactor, TaskBuilderInteractorInput {
    typealias Output = TaskBuilderInteractorOutput
    weak var output: TaskBuilderInteractorOutput!
}
