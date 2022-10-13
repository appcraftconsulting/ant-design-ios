//
//  Color+AntDesign.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public extension Color {
    enum BaseColorPalette: String {
        case red
        case volcano
        case orange
        case gold
        case yellow
        case lime
        case green
        case cyan
        case blue
        case geekblue
        case purple
        case magenta
        
        case incarnat
    }
    
    enum PreferencesColor: String {
        case btnTextHoverBg = "@btn-text-hover-bg"
        case bodyBackground = "@body-background"
        case componentBackground = "@component-background"
        case btnDefaultGhostBorder = "@btn-default-ghost-border"
        case btnDefaultGhostColor = "@btn-default-ghost-color"
        case messageNoticeContentBg = "@message-notice-content-bg"
        case progressStepsItemBg = "@progress-steps-item-bg"
        case headingColor = "@heading-color"
        case textColor = "@text-color"
        case textColorSecondary = "@text-color-secondary"
        case iconColorHover = "@icon-color-hover"
        case cardSkeletonBg = "@card-skeleton-bg"
        case borderColorBase = "@border-color-base"
        case borderColorSplit = "@border-color-split"
        case itemHoverBg = "@item-hover-bg"
        case selectMultipleItemDisabledColor = "@select-multiple-item-disabled-color"
        case disabledColor = "@disabled-color"
        case backgroundColorLight = "@background-color-light"
        case backgroundColorBase = "@background-color-base"
        case tableBodySortBg = "@table-body-sort-bg"
        case tableExpandedRowBg = "@table-expanded-row-bg"
        case tableHeaderCellSplitColor = "@table-header-cell-split-color"
        case radioSolidCheckedColor = "@radio-solid-checked-color"
        case radioDotDisabledColor = "@radio-dot-disabled-color"
        case radioDisabledButtonCheckedBg = "@radio-disabled-button-checked-bg"
        case inputIconHoverColor = "@input-icon-hover-color"
        case checkboxCheckBg = "@checkbox-check-bg"
        case tableExpandIconBg = "@table-expand-icon-bg"
        case inputBg = "@input-bg"
        case inputPlaceholderColor = "@input-placeholder-color"
        case inputIconColor = "@input-icon-color"
        case inputNumberHandlerActiveBg = "@input-number-handler-active-bg"
    }
    
    enum NeutralColorPalette: String {
        case gray
    }
    
    enum FunctionalColor: String {
        case link, success, warning, error
    }
    
    static func base(_ palette: BaseColorPalette, _ index: Int) -> Self {
        color(palette.rawValue, index: index)
    }
    
    static func preferences(_ color: PreferencesColor) -> Self {
        .init(color.rawValue, bundle: .module)
    }

    static func functional(_ color: FunctionalColor) -> Self {
        switch color {
        case .link:
            return base(.blue, 6)
        case .success:
            return base(.green, 6)
        case .warning:
            return base(.gold, 6)
        case .error:
            return base(.red, 5)
        }
    }
    
    // MARK: - Private functions
    
    private static func color(_ rawValue: String, index: Int) -> Color {
        .init(.init(format: "%@-%d", rawValue, index), bundle: .module)
    }
}

internal extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
