//
//  ButtonStyle+Attributes+Link.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

internal extension ButtonStyle.Attributes {
    static var linkGhostDanger: Self {
        print("`link` or `text` button can't be a `ghost` button.")
        return linkDanger
    }
    
    static var linkGhost: Self {
        print("`link` or `text` button can't be a `ghost` button.")
        return link
    }
    
    static var linkDanger: Self {
        .init(
            foregroundColor: .error,
            backgroundColor: .init(
                pressed: .clear,
                hovered: Preferences.btnLinkHoverBg,
                idle: .clear
            )
        )
    }
    
    static var link: Self {
        .init(
            foregroundColor: .primary,
            backgroundColor: .init(
                pressed: .clear,
                hovered: Preferences.btnLinkHoverBg,
                idle: .clear
            )
        )
    }
    
    static var linkDisabled: Self {
        .init(
            foregroundColor: .all(Preferences.btnDisableColor),
            backgroundColor: .all(.clear)
        )
    }
}
