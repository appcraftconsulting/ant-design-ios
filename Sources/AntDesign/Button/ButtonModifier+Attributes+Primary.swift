//
//  ButtonModifier+Attributes+Primary.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

internal extension ButtonModifier.Attributes {
    static var primaryGhostDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .error,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var primaryGhostDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(Preferences.btnDisableBg),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var primaryGhost: Self {
        .init(
            foregroundColor: .primary,
            backgroundColor: .all(Preferences.btnDefaultGhostBg),
            borderColor: .primary,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var primaryDanger: Self {
        .init(
            foregroundColor: .all(Preferences.btnDangerColor),
            backgroundColor: .error,
            borderColor: .error,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var primary: Self {
        .init(
            foregroundColor: .all(Preferences.btnDangerColor),
            backgroundColor: .primary,
            borderColor: .primary,
            borderStyle: Preferences.btnBorderStyle
        )
    }
    
    static var primaryDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(Preferences.btnDisableBg),
            borderColor: .all(Preferences.btnDisableBorder),
            borderStyle: Preferences.btnBorderStyle
        )
    }
}
