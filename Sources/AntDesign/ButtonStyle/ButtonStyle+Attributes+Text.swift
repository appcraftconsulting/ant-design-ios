//
//  ButtonStyle+Attributes+Text.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

internal extension ButtonStyle.ContentView.Attributes {
    static var textGhostDanger: Self {
        print("`link` or `text` button can't be a `ghost` button.")
        return textDanger
    }
    
    static var textGhost: Self {
        print("`link` or `text` button can't be a `ghost` button.")
        return text
    }
    
    static var textDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .init(
                pressed: Preferences.btnTextHoverBg,
                hovered: Preferences.btnTextHoverBg,
                idle: .clear
            )
        )
    }
    
    static var text: Self {
        .init(
            foregroundColor: .init(
                pressed: Preferences.textColor,
                hovered: Preferences.textColor,
                idle: Preferences.textColor
            ),
            backgroundColor: .init(
                pressed: Preferences.btnTextHoverBg,
                hovered: Preferences.btnTextHoverBg,
                idle: .clear
            )
        )
    }
    
    static var textDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(.clear)
        )
    }
}
