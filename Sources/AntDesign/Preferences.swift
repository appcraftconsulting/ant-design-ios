//
//  Preferences.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public enum Preferences {
    // -------- Colors -----------
    // >>> Primary
    static var primaryColorPalette: Color.BaseColorPalette = .blue
    static var primaryColor: Color = .base(primaryColorPalette, 6)
    static var primaryColorHover: Color = .base(primaryColorPalette, 5)
    static var primaryColorActive: Color = .base(primaryColorPalette, 7)
    static var primaryColorOutline: Color = primaryColor.opacity(outlineFade)
    
    static  var processingColor: Color = .base(.blue, 6)
    
    // >>> Info
    static var infoColorPalette: Color.BaseColorPalette = primaryColorPalette
    static var infoColorDeprecatedBg: Color = .base(infoColorPalette, 1)
    static var infoColorDeprecatedBorder: Color = .base(infoColorPalette, 3)
    
    // >>> Error
    static var errorColorPalette: Color.BaseColorPalette = .red
    static var errorColor: Color = .base(errorColorPalette, 5)
    static var errorColorHover: Color = .base(errorColorPalette, 5)
    static var errorColorActive: Color = .base(errorColorPalette, 7)
    static var errorColorOutline = errorColor.opacity(outlineFade)
    static var errorColorDeprecatedBg: Color = .base(errorColorPalette, 1)
    static var errorColorDeprecatedBorder: Color = .base(errorColorPalette, 3)
    
    // Border color
    static var borderColorSplit : Color = .black.opacity(0.94)
    static var borderWidthBase: CGFloat = 1 // width of the border for a component
    
    // vertical paddings
    static var paddingLg: CGFloat = 24 // containers
    static var paddingMd: CGFloat = 16 // small containers and buttons
    static var paddingSm: CGFloat = 12 // Form controls and items
    static var paddingXs: CGFloat = 8 // small items
    static var paddingXss: CGFloat = 4 // more small
    
    // height rules
    static var heightBase: CGFloat = 32
    static var heightLg: CGFloat = 40
    static var heightSm: CGFloat = 24
    
    // Outline
    static var outlineBlurSize: CGFloat = 0
    static var outlineWidth: CGFloat = 2
    static var outlineFade: CGFloat = 0.2
    
    static var backgroundColorBase: Color = .neutral(.componentBackground)
    static var textColor: Color = .neutral(.primaryText)
    static var textColorSecondary: Color = .neutral(.secondaryText)
    
    // Disabled states
    static var disabledColor: Color = .neutral(.disable)
    static var disabledBg = backgroundColorBase
    static var disabledActiveBg: Color = .black.opacity(0.90)
    
    // Base background color for most components
    static var componentBackground: Color = .neutral(.componentBackground)
    
    static var borderRadiusBase: CGFloat = 2
    
    // Buttons
    
    static var btnBorderRadiusBase = borderRadiusBase
    static var btnBorderRadiusSm = borderRadiusBase
    static var btnBorderWidth = borderWidthBase
    
    static var btnPrimaryColor: Color = .neutral(.gray, 1)
    static var btnPrimaryBg = primaryColor
    
    static var btnDefaultColor: Color = .neutral(.primaryText)
    static var btnDefaultBg = componentBackground
    static var btnDefaultBorder: Color = .neutral(.border)

    static var btnDangerColor: Color = .neutral(.gray, 1)
    static var btnDangerBg: Color = .functional(.error)
    static var btnDangerBorder: Color = .functional(.error)
    
    static var btnDisableColor = disabledColor
    static var btnDisableBg = disabledBg
    static var btnDisableBorder : Color = .neutral(.border)

    static var btnDefaultGhostColor: Color = .neutral(.gray, 1)
    static var btnDefaultGhostBg: Color = .clear
    static var btnDefaultGhostBorder: Color = .neutral(.gray, 1)

    static var btnPaddingHorizontalBase = paddingMd - 1
    static var btnPaddingHorizontalLg = btnPaddingHorizontalBase
    static var btnPaddingHorizontalSm = paddingXs - 1

    static var btnHeightBase = heightBase
    static var btnHeightLg = heightLg
    static var btnHeightSm = heightSm
    
    static var btnCircleSize = btnHeightBase
    static var btnCircleSizeLg = btnHeightLg
    static var btnCircleSizeSm = btnHeightSm
    
    static var btnSquareSize = btnHeightBase
    static var btnSquareSizeLg = btnHeightLg
    static var btnSquareSizeSm = btnHeightSm
    
    static var btnLinkHoverBg: Color = .clear
    static var btnTextHoverBg: Color = .black.opacity(0.018)
}
