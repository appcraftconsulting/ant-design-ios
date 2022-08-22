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
    public static var primaryColorPalette: Color.BaseColorPalette = .blue
    public static var primaryColor: Color = .base(primaryColorPalette, 6)
    public static var primaryColorHover: Color = .base(primaryColorPalette, 5)
    public static var primaryColorActive: Color = .base(primaryColorPalette, 7)
    public static var primaryColorOutline: Color = primaryColor.opacity(outlineFade)
    
    public static  var processingColor: Color = .base(.blue, 6)
    
    // >>> Info
    public static var infoColorPalette: Color.BaseColorPalette = primaryColorPalette
    public static var infoColor: Color = .base(infoColorPalette, 6)
    public static var infoColorDeprecatedBg: Color = .base(infoColorPalette, 1)
    public static var infoColorDeprecatedBorder: Color = .base(infoColorPalette, 3)
    
    // >>> Success
    public static var successColorPalette: Color.BaseColorPalette = .green
    public static var successColor: Color = .base(successColorPalette, 6)
    public static var successColorHover: Color = .base(successColorPalette, 5)
    public static var successColorActive: Color = .base(successColorPalette, 7)
    public static var successColorOutline = successColor.opacity(outlineFade)
    public static var successColorDeprecatedBg: Color = .base(successColorPalette, 1)
    public static var successColorDeprecatedBorder: Color = .base(successColorPalette, 3)

    // >>> Warning
    public static var warningColorPalette: Color.BaseColorPalette = .gold
    public static var warningColor: Color = .base(warningColorPalette, 6)
    public static var warningColorHover: Color = .base(warningColorPalette, 5)
    public static var warningColorActive: Color = .base(warningColorPalette, 7)
    public static var warningColorOutline = warningColor.opacity(outlineFade)
    public static var warningColorDeprecatedBg: Color = .base(warningColorPalette, 1)
    public static var warningColorDeprecatedBorder: Color = .base(warningColorPalette, 3)
    
    // >>> Error
    public static var errorColorPalette: Color.BaseColorPalette = .red
    public static var errorColor: Color = .base(errorColorPalette, 5)
    public static var errorColorHover: Color = .base(errorColorPalette, 5)
    public static var errorColorActive: Color = .base(errorColorPalette, 7)
    public static var errorColorOutline = errorColor.opacity(outlineFade)
    public static var errorColorDeprecatedBg: Color = .base(errorColorPalette, 1)
    public static var errorColorDeprecatedBorder: Color = .base(errorColorPalette, 3)
    
    // Border color
    public static var borderColorBase: Color = .preferences(.borderColorBase)
    public static var borderColorSplit : Color = .preferences(.borderColorSplit)
    public static var borderColorInverse: Color = .white
    public static var borderWidthBase: CGFloat = 1 // width of the border for a component
    public static var borderStyleBase: BorderStyle = .solid // style of a components border
    
    // vertical paddings
    public static var paddingLg: CGFloat = 24 // containers
    public static var paddingMd: CGFloat = 16 // small containers and buttons
    public static var paddingSm: CGFloat = 12 // Form controls and items
    public static var paddingXs: CGFloat = 8 // small items
    public static var paddingXss: CGFloat = 4 // more small
    
    // height rules
    public static var heightBase: CGFloat = 32
    public static var heightLg: CGFloat = 40
    public static var heightSm: CGFloat = 24
    
    // Outline
    public static var outlineBlurSize: CGFloat = 0
    public static var outlineWidth: CGFloat = 2
    public static var outlineFade: CGFloat = 0.2
    
    public static var backgroundColorBase: Color = .neutral(.disableBackground)
    public static var textColor: Color = .preferences(.textColor)
    public static var textColorSecondary: Color = .preferences(.textColorSecondary)
    public static var textColorInverse: Color = .white
    public static var iconColorHover: Color = .preferences(.iconColorHover)
    public static var headingColor: Color = .preferences(.headingColor)

    // Disabled states
    public static var disabledColor: Color = .neutral(.disable)
    public static var disabledBg: Color = .neutral(.disableBackground)
    public static var disabledActiveBg: Color = .black.opacity(0.90)
    
    // Base background color for most components
    public static var componentBackground: Color = .preferences(.componentBackground)
    
    public static var fontSizeBase: CGFloat = 15
    public static var fontSizeLg = fontSizeBase + 2
    public static var fontSizeSm: CGFloat = 13
    public static var borderRadiusBase: CGFloat = 2
    public static var borderRadiusSm = borderRadiusBase
    public static var lineHeightBase: CGFloat = 1.5715
    
    // Buttons
    public static var btnFontWeight: Font.Weight = .regular
    public static var btnBorderRadiusBase = borderRadiusBase
    public static var btnBorderRadiusSm = borderRadiusBase
    public static var btnBorderWidth = borderWidthBase
    public static var btnBorderStyle = borderStyleBase
    public static var btnShadow: Shadow = .init(color: .black.opacity(0.015), offset: .init(x: 0, y: 2))
    public static var btnPrimaryShadow: Shadow = .init(color: .black.opacity(0.045), offset: .init(x: 0, y: 2))
    public static var btnTextShadow: Shadow = .init(color: .black.opacity(0.120), offset: .init(x: 0, y: -1))
    
    public static var btnPrimaryColor: Color = .neutral(.gray, 1)
    public static var btnPrimaryBg = primaryColor
    
    public static var btnDefaultColor: Color = textColor
    public static var btnDefaultBg = componentBackground
    public static var btnDefaultBorder: Color = .neutral(.border)

    public static var btnDangerColor: Color = .neutral(.gray, 1)
    public static var btnDangerBg: Color = .functional(.error)
    public static var btnDangerBorder: Color = .functional(.error)
    
    public static var btnDisableColor = disabledColor
    public static var btnDisableBg = disabledBg
    public static var btnDisableBorder : Color = .neutral(.border)

    public static var btnDefaultGhostColor: Color = .preferences(.btnDefaultGhostColor)
    public static var btnDefaultGhostBg: Color = .clear
    public static var btnDefaultGhostBorder: Color = .preferences(.btnDefaultGhostBorder)

    public static var btnPaddingHorizontalBase = paddingMd - 1
    public static var btnPaddingHorizontalLg = btnPaddingHorizontalBase
    public static var btnPaddingHorizontalSm = paddingXs - 1

    public static var btnHeightBase = heightBase
    public static var btnHeightLg = heightLg
    public static var btnHeightSm = heightSm
    
    public static var btnCircleSize = btnHeightBase
    public static var btnCircleSizeLg = btnHeightLg
    public static var btnCircleSizeSm = btnHeightSm
    
    public static var btnSquareSize = btnHeightBase
    public static var btnSquareSizeLg = btnHeightLg
    public static var btnSquareSizeSm = btnHeightSm
    
    public static var btnLinkHoverBg: Color = .clear
    public static var btnTextHoverBg: Color = .preferences(.btnTextHoverBg)
    
    // Switch
    // ---
    public static var switchHeight: CGFloat = 22
    public static var switchSmHeight: CGFloat = 16
    public static var switchMinWidth: CGFloat = 44
    public static var switchSmMinWidth: CGFloat = 28
    public static var switchDisabledOpacity: CGFloat = 0.4
    public static var switchColor = primaryColor
    public static var switchBg: Color = .white
    public static var switchShadowColor = Color(hex: 0x00230b, alpha: 0.2)
    public static var switchPadding: CGFloat = 2
    public static var switchInnerMarginMin = ceil(switchHeight * 0.3)
    public static var switchInnerMarginMax = ceil(switchHeight * 1.1)
    public static var switchSmInnerMarginMin = ceil(switchHeight * 0.3)
    public static var switchSmInnerMarginMax = ceil(switchHeight * 1.1)
    
    // Message
    // ---
    public static var messageNoticeContentPadding: EdgeInsets = .init(top: 10, leading: 16, bottom: 10, trailing: 16)
    public static var messageNoticeContentBg: Color = .preferences(.messageNoticeContentBg)
    
    // Progress
    // --
    public static var progressDefaultColor = processingColor
    public static var progressRemainingColor = backgroundColorBase
    public static var progressInfoTextColor = progressTextColor
    public static var progressRadius: CGFloat = 100
    public static var progressStepsItemBg: Color = .preferences(.progressStepsItemBg)
    public static var progressTextColor = textColor // This is for circle text color, should be renamed better
    public static var progressCircleTextFontSize = fontSizeLg
    
    // Alert
    // ---
    public static var alertSuccessBorderColor: Color = .base(successColorPalette, 3)
    public static var alertSuccessBgColor: Color = .base(successColorPalette, 1)
    public static var alertSuccessIconColor = successColor
    public static var alertInfoBorderColor: Color = .base(infoColorPalette, 3)
    public static var alertInfoBgColor: Color = .base(infoColorPalette, 1)
    public static var alertInfoIconColor = infoColor
    public static var alertWarningBorderColor: Color = .base(warningColorPalette, 3)
    public static var alertWarningBgColor: Color = .base(warningColorPalette, 1)
    public static var alertWarningIconColor = warningColor
    public static var alertErrorBorderColor: Color = .base(errorColorPalette, 3)
    public static var alertErrorBgColor: Color = .base(errorColorPalette, 1)
    public static var alertErrorIconColor = errorColor
    public static var alertMessageColor = headingColor
    public static var alertTextColor = textColor
    public static var alertCloseColor = textColorSecondary
    public static var alertCloseHoverColor = iconColorHover
    public static var alertNoIconPaddingVertical = paddingXs
    public static var alertWithDescriptionNoIconPaddingVertical = paddingMd - 1
    public static var alertWithDescriptionPaddingVertical = paddingMd - 1
    public static var alertWithDescriptionPadding: EdgeInsets = .init(
        top: alertWithDescriptionPaddingVertical,
        leading: alertWithDescriptionIconSize,
        bottom: alertWithDescriptionNoIconPaddingVertical,
        trailing: 15
    )
    public static var alertIconTop = 8 + fontSizeBase * (lineHeightBase / 2) - (fontSizeBase / 2)
    public static var alertWithDescriptionIconSize: CGFloat = 24
    
    // Card
    // ---
    public static var cardHeadColor = headingColor
    public static var cardHeadBackground: Color = .clear
    public static var cardHeadFontSize = fontSizeLg
    public static var cardHeadFontSizeSm = fontSizeBase
    public static var cardHeadPadding: CGFloat = 16
    public static var cardHeadPaddingSm = cardHeadPadding / 2
    public static var cardHeadHeight: CGFloat = 48
    public static var cardHeadHeightSm: CGFloat = 36
    public static var cardInnerHeadPadding: CGFloat = 12
    public static var cardPaddingBase: CGFloat = 24
    public static var cardPaddingBaseSm = cardPaddingBase / 2
    public static var cardActionsBackground = componentBackground
    public static var cardActionsLiMargin: EdgeInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
    public static var cardSkeletonBg: Color = .preferences(.cardSkeletonBg)
    public static var cardBackground = componentBackground
    public static var cardRadius = borderRadiusBase
    public static var cardHeadTabsMarginBottom: CGFloat = -17
    public static var cardHeadExtraColor = textColor
}
