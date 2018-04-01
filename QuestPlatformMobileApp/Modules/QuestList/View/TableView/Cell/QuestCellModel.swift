//
//  QuestCellModel.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

final class QuestCellModel: CellViewModel {
    
    let quest: Quest
    
    init(quest: Quest) {
        self.quest = quest
    }
    
    func setup(cell: QuestTableViewCell) {
        cell.titleLabel.text = quest.name
    }
}
