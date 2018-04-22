//
//  MenuItemCellModel.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct MenuItemCellModel: CellViewModel {
    
    let title: String
    let handler: () -> Void
    
    func setup(cell: MenuItemTableViewCell) {
        cell.title = title
    }
}
