//
//  Theme.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit

enum Theme {
    enum Button {
        enum Color {
            static let title = UIColor.white
            static let lightBlue = UIColor(r: 58, g: 204, b: 225)
        }
        enum Font {
            static let `default` = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    enum TextField {
        enum Color {
            static let text = UIColor.black
            static let placeholder = UIColor(r: 120, g: 132, b: 158)
            static let background = UIColor.white
            static let shadow = UIColor(r: 69, g: 91, b: 99)
        }
        enum Font {
            static let `default` = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
}
