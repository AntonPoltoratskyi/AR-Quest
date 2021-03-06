//
//  Theme.swift
//  ARQuest
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
            static let lightBlueHighlighted = UIColor(r: 62, g: 189, b: 209)
            static let darkGray = UIColor(r: 53, g: 58, b: 80)
        }
        enum Font {
            static let `default` = UIFont.appFont(ofSize: 15, weight: .regular)
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
            static let `default` = UIFont.appFont(ofSize: 15, weight: .regular)
        }
    }
    enum Label {
        enum Color {
            static let error = UIColor.red
        }
        enum Font {
            static let error = UIFont.appFont(ofSize: 13, weight: .regular)
        }
    }
    enum SegmentedControl {
        enum Color {
            static let normalColor = UIColor.clear
            static let selectedColor = UIColor(r: 102, g: 94, b: 255)
            
            static let normalTextColor = UIColor(r: 120, g: 132, b: 158)
            static let selectedTextColor = UIColor.white
        }
        enum Font {
            static let `default` = UIFont.appFont(ofSize: 12, weight: .medium)
        }
    }
    enum CardView {
        enum Color {
            static let backgroundColor = UIColor.white
            static let highlightedColor = UIColor.lightGray.withAlphaComponent(0.7)
            static let shadow = UIColor(r: 69, g: 91, b: 99)
        }
    }
    enum NavigationView {
        enum Color {
            static let backgroundColor = UIColor(r: 42, g: 46, b: 67)
            static let titleColor = UIColor.white
        }
        enum Font {
            static let titleFont = UIFont.appFont(ofSize: 18, weight: .medium)
        }
    }
    enum Background {
        static let blueBackground = UIColor(r: 102, g: 94, b: 255)
    }
    enum Avatar {
        static let placeholderBackground = UIColor.white
        static let placeholderBorder = UIColor.lightGray
    }
    
    enum Header {
        enum Font {
            static let `default` = UIFont.appFont(ofSize: 24, weight: .semibold)
        }
        enum Color {
            static let background = UIColor.white
        }
        enum Separator {
            static let background = UIColor.darkText
        }
    }
}

extension UIFont {
    static func appFont(ofSize fontSize: CGFloat, weight: Weight) -> UIFont {
        return systemFont(ofSize: fontSize, weight: weight)
    }
}
