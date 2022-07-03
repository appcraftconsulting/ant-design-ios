//
//  Buttton+Attributes.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

extension Button {
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
        
        enum BorderStyle {
            case solid, dashed
            
            var dash: [CGFloat] {
                switch self {
                case .solid:
                    return []
                case .dashed:
                    return [4]
                }
            }
        }
        
        let foregroundColor: InteractiveColor
        let backgroundColor: InteractiveColor
        var borderColor: InteractiveColor?
        var borderStyle: BorderStyle?
        
        // MARK: - Primary Button
        
        static var primaryGhostDanger: Self {
            .init(
                foregroundColor: .error,
                backgroundColor: .all(Preferences.btnDefaultGhostBg),
                borderColor: .error,
                borderStyle: .solid
            )
        }
        
        static var primaryGhost: Self {
            .init(
                foregroundColor: .primary,
                backgroundColor: .all(Preferences.btnDefaultGhostBg),
                borderColor: .primary,
                borderStyle: .solid
            )
        }
        
        static var primaryDanger: Self {
            .init(
                foregroundColor: .all(Preferences.btnDangerColor),
                backgroundColor: .error,
                borderColor: .error,
                borderStyle: .solid
            )
        }
        
        static var primaryDisabled: Self {
            .init(
                foregroundColor: .all(Preferences.btnDisableColor),
                backgroundColor: .all(Preferences.btnDisableBg),
                borderColor: .all(Preferences.btnDisableBorder),
                borderStyle: .solid
            )
        }
        
        static var primary: Self {
            .init(
                foregroundColor: .all(Preferences.btnDangerColor),
                backgroundColor: .primary,
                borderColor: .primary,
                borderStyle: .solid
            )
        }
        
        // MARK: - Default Button
        
        static var defaultGhostDanger: Self {
            .init(
                foregroundColor: .error,
                backgroundColor: .all(Preferences.btnDefaultGhostBg),
                borderColor: .error,
                borderStyle: .solid
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
                borderStyle: .solid
            )
        }
        
        static var defaultDanger: Self {
            .init(
                foregroundColor: .error,
                backgroundColor: .all(Preferences.componentBackground),
                borderColor: .error,
                borderStyle: .solid
            )
        }
        
        static var defaultDisabled: Self {
            primaryDisabled
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
                borderStyle: .solid
            )
        }
    }
}
