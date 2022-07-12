//
//  ButtonModifier+Attributes+Default.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

internal extension ButtonModifier.Attributes {
    static var defaultGhostDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .error,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var defaultGhostDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var defaultGhost: Self {
        .init(
            foregroundColor: .init(
                pressed: Preferences.primaryColorActive,
                hovered: Preferences.primaryColorHover,
                idle: Preferences.btnDefaultGhostColor
            ),
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .init(
                pressed: Preferences.primaryColorActive,
                hovered: Preferences.primaryColorHover,
                idle: Preferences.btnDefaultGhostBorder
            ),
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var defaultDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .all(Preferences.componentBackground),
            borderColor: .error,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var defaultDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(Preferences.btnDisableBg),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var `default`: Self {
        .init(
            foregroundColor: .init(
                pressed: Preferences.primaryColorActive,
                hovered: Preferences.primaryColorHover,
                idle: Preferences.btnDefaultColor
            ),
            backgroundColor: .all(Preferences.componentBackground),
            borderColor: .init(
                pressed: Preferences.primaryColorActive,
                hovered: Preferences.primaryColorHover,
                idle: Preferences.btnDefaultBorder
            ),
            borderStyle: Preferences.btnBorderStyle
        )
    }
}
