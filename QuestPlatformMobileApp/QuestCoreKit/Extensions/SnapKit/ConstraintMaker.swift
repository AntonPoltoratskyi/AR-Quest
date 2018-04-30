//
//  ConstraintMaker.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 04.03.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SnapKit

extension ConstraintMaker {
    
    @discardableResult
    func buttonHeight() -> ConstraintMakerEditable {
        return height.equalTo(48)
    }
    
    @discardableResult
    func textFieldHeight() -> ConstraintMakerEditable {
        return height.equalTo(48)
    }
    
    @discardableResult
    func segmentedControlActionHeight() -> ConstraintMakerEditable {
        return height.equalTo(32)
    }
    
    @discardableResult
    func navigationViewHeight() -> ConstraintMakerEditable {
        return height.equalTo(44)
    }
    
    @discardableResult
    func sideMenuHeaderHeight() -> ConstraintMakerEditable {
        return height.equalTo(160)
    }
    
    func horizontalInset(_ inset: CGFloat) {
        left.equalToSuperview().offset(inset)
        right.equalToSuperview().inset(inset)
    }
}
