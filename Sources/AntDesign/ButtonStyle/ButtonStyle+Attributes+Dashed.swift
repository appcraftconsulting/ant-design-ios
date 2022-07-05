//
//  ButtonStyle+Attributes+Dashed.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

internal extension ButtonStyle.Attributes {
    static var dashedGhostDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .error,
            borderStyle: .dashed
        )
    }
    
    static var dashedGhostDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(.clear),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: .dashed
        )
    }
    
    static var dashedGhost: Self {
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
            borderStyle: .dashed
        )
    }
    
    static var dashedDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .all(Preferences.componentBackground),
            borderColor: .error,
            borderStyle: .dashed
        )
    }
    
    static var dashedDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(Preferences.btnDisableBg),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: .dashed
        )
    }
    
    static var dashed: Self {
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
            borderStyle: .dashed
        )
    }
}
