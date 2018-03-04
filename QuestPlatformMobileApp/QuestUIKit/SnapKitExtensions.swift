//
//  SnapKitExtensions.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SnapKit

extension ConstraintMaker {
    
    @discardableResult
    func buttonHeight() -> ConstraintMakerEditable {
        return self.height.equalTo(52)
    }
    
    @discardableResult
    func textFieldHeight() -> ConstraintMakerEditable {
        return self.height.equalTo(52)
    }
}
