//
//  QuestTaskCellModel.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestTaskCellModel: CellViewModel {
    
    let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func setup(cell: QuestTaskTableViewCell) {
        cell.titleLabel.text = task.title
    }
}
