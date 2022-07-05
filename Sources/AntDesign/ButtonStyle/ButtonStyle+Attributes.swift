//
//  ButtonStyle+Attributes.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

internal extension ButtonStyle {
    struct Attributes {
        struct InteractiveColor {
            let pressed: Color
            let hovered: Color
            let idle: Color
            
            static func all(_ color: Color) -> Self {
                .init(pressed: color, hovered: color, idle: color)
            }
            
            static var error: Self {
                .init(
                    pressed: Preferences.errorColorActive,
                    hovered: Preferences.errorColorHover,
                    idle: Preferences.errorColor
                )
            }
            
            static var primary: Self {
                .init(
                    pressed: Preferences.primaryColorActive,
                    hovered: Preferences.primaryColorHover,
                    idle: Preferences.primaryColor
                )
            }
        }
        
        let foregroundColor: InteractiveColor
        let backgroundColor: InteractiveColor
        var borderColor: InteractiveColor?
        var borderStyle: BorderStyle?
    }
}

extension ButtonStyle {
    internal func attributes(danger: Bool) -> Attributes {
        switch (type, ghost, danger, isEnabled) {
        case (.primary, false, false, true):
            return .primary
        case (.primary, true, false, true):
            return .primaryGhost
        case (.primary, false, true, true):
            return .primaryDanger
        case (.primary, true, true, true):
            return .primaryGhostDanger
        case (.primary, true, _, false):
            return .primaryGhostDisabled
        case (.primary, false, _, false):
            return .primaryDisabled
            
        case (.default, false, false, true):
            return .default
        case (.default, true, false, true):
            return .defaultGhost
        case (.default, false, true, true):
            return .defaultDanger
        case (.default, true, true, true):
            return .defaultGhostDanger
        case (.default, true, _, false):
            return .defaultGhostDisabled
        case (.default, false, _, false):
            return .defaultDisabled
            
        case (.dashed, false, false, true):
            return .dashed
        case (.dashed, true, false, true):
            return .dashedGhost
        case (.dashed, false, true, true):
            return .dashedDanger
        case (.dashed, true, true, true):
            return .dashedGhostDanger
        case (.dashed, true, _, false):
            return .dashedGhostDisabled
        case (.dashed, false, _, false):
            return .dashedDisabled
            
        case (.link, false, false, true):
            return .link
        case (.link, true, false, true):
            return .linkGhost
        case (.link, false, true, true):
            return .linkDanger
        case (.link, true, true, true):
            return .linkGhostDanger
        case (.link, _, _, false):
            return .linkDisabled
            
        case (.text, false, false, true):
            return .text
        case (.text, true, false, true):
            return .textGhost
        case (.text, false, true, true):
            return .textDanger
        case (.text, true, true, true):
            return .textGhostDanger
        case (.text, _, _, false):
            return .textDisabled
        }
    }
}
