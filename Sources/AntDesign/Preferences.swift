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
    
    public static var highlightColor: Color = .base(.red, 5)
    public static var normalColor: Color = .init(hex: 0xd9d9d9)
    
    // Animation
    public static var easeBaseOut: Animation = .timingCurve(0.7, 0.3, 0.1, 1)
    public static var easeBaseIn: Animation = .timingCurve(0.9, 0, 0.3, 0.7)
    public static var easeOut: Animation = .timingCurve(0.215, 0.61, 0.355, 1)
    public static var easeIn: Animation = .timingCurve(0.55, 0.055, 0.675, 0.19)
    public static var easeInOut: Animation = .timingCurve(0.645, 0.045, 0.355, 1)
    public static var easeOutBack: Animation = .timingCurve(0.12, 0.4, 0.29, 1.46, duration: 0.1)
    public static var easeInBack: Animation = .timingCurve(0.71, -0.46, 0.88, 0.6)
    public static var easeInOutBack: Animation = .timingCurve(0.71, -0.46, 0.29, 1.46)
    public static var easeOutCirc: Animation = .timingCurve(0.08, 0.82, 0.17, 1)
    public static var easeInCirc: Animation = .timingCurve(0.6, 0.04, 0.98, 0.34)
    public static var easeInOutCirc: Animation = .timingCurve(0.78, 0.14, 0.15, 0.86)
    public static var easeOutQuint: Animation = .timingCurve(0.23, 1, 0.32, 1)
    public static var easeInQuint: Animation = .timingCurve(0.755, 0.05, 0.855, 0.06)
    public static var easeInOutQuint: Animation = .timingCurve(0.86, 0, 0.07, 1)
    
    // Border color
    /// base border outline a component
    public static var borderColorBase: Color = .preferences(.borderColorBase)
    /// split border inside a component
    public static var borderColorSplit : Color = .preferences(.borderColorSplit)
    public static var borderColorInverse: Color = .white
    /// width of the border for a component
    public static var borderWidthBase: CGFloat = 1
    /// style of a components border
    public static var borderStyleBase: BorderStyle = .solid
    
    // vertical paddings
    public static var paddingLg: CGFloat = 24 // containers
    public static var paddingMd: CGFloat = 16 // small containers and buttons
    public static var paddingSm: CGFloat = 12 // Form controls and items
    public static var paddingXs: CGFloat = 8 // small items
    public static var paddingXss: CGFloat = 4 // more small
    
    // vertical padding for all form controls
    public static var controlPaddingHorizontal = paddingSm
    public static var controlPaddingHorizontalSm = paddingXs;
    
    // vertical margins
    public static var marginLg: CGFloat = 24 // containers
    public static var marginMd: CGFloat = 16 // small containers and buttons
    public static var marginSm: CGFloat = 12 // Form controls and items
    public static var marginXs: CGFloat = 8 // small items
    public static var marginXss: CGFloat = 4 // more small
    
    // height rules
    public static var heightBase: CGFloat = 32
    public static var heightLg: CGFloat = 40
    public static var heightSm: CGFloat = 24
    
    // The background colors for active and hover states for things like
    // list items or table cells.
    public static var itemActiveBg: Color = .base(primaryColorPalette, 1)
    public static var itemHoverBg: Color = .preferences(.itemHoverBg)
    
    // Outline
    public static var outlineBlurSize: CGFloat = 0
    public static var outlineWidth: CGFloat = 2
    public static var outlineFade: CGFloat = 0.2
    
    /// background of header and selected item
    public static var backgroundColorLight: Color = .preferences(.backgroundColorLight)
    /// Default grey background color
    public static var backgroundColorBase: Color = .preferences(.backgroundColorBase)
    
    public static var textColor: Color = .preferences(.textColor)
    public static var textColorSecondary: Color = .preferences(.textColorSecondary)
    public static var textColorInverse: Color = .white
    public static var iconColorHover: Color = .preferences(.iconColorHover)
    public static var headingColor: Color = .preferences(.headingColor)
    
    // Disabled states
    public static var disabledColor: Color = .preferences(.disabledColor)
    public static var disabledBg: Color = backgroundColorBase
    public static var disabledActiveBg: Color = .black.opacity(0.90)
    
    /// Background color for `<body>`
    public static var bodyBackground: Color = .preferences(.bodyBackground)
    /// Base background color for most components
    public static var componentBackground: Color = .preferences(.componentBackground)
    /// Popover background color
    public static var popoverBackground = componentBackground
    
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
    
    public static var btnPrimaryColor: Color = .white
    public static var btnPrimaryBg = primaryColor
    
    public static var btnDefaultColor: Color = textColor
    public static var btnDefaultBg = componentBackground
    public static var btnDefaultBorder = borderColorBase
    
    public static var btnDangerColor: Color = .white
    public static var btnDangerBg: Color = .functional(.error)
    public static var btnDangerBorder: Color = .functional(.error)
    
    public static var btnDisableColor = disabledColor
    public static var btnDisableBg = disabledBg
    public static var btnDisableBorder = borderColorBase
    
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
    
    // Checkbox
    public static var checkboxSize: CGFloat = 16
    public static var checkboxColor = primaryColor
    public static var checkboxCheckColor: Color = .white
    public static var checkboxCheckBg: Color = .preferences(.checkboxCheckBg)
    public static var checkboxBorderWidth = borderWidthBase
    public static var checkboxBorderRadius = borderRadiusBase
    public static var checkboxGroupItemMarginRight: CGFloat = 8
    
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
    
    // Form
    // ---
    public static var labelRequiredColor = highlightColor
    public static var labelColor = headingColor
    public static var formWarningInputBg = inputBg
    public static var formItemMarginBottom: CGFloat = 24
    public static var formItemTrailingColon = true
    public static var formVerticalLabelPadding: EdgeInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
    public static var formVerticalLabelMargin: CGFloat = 0
    public static var formItemLabelFontSize = fontSizeBase
    public static var formItemLabelHeight = inputHeightBase
    public static var formItemLabelColonMarginRight: CGFloat = 8
    public static var formItemLabelColonMarginLeft: CGFloat = 2
    public static var formErrorInputBg = inputBg
    
    // Input
    // ---
    public static var inputHeightBase = heightBase
    public static var inputHeightLg = heightLg
    public static var inputHeightSm = heightSm
    public static var inputPaddingHorizontal = controlPaddingHorizontal - 1
    public static var inputPaddingHorizontalBase = inputPaddingHorizontal
    public static var inputPaddingHorizontalSm = controlPaddingHorizontalSm - 1
    public static var inputPaddingHorizontalLg = inputPaddingHorizontal
    public static var inputPaddingVerticalBase: CGFloat = max(
        (round(((inputHeightBase - fontSizeBase * lineHeightBase) / 2) * 10) / 10) - borderWidthBase, 3
    )
    public static var inputPaddingVerticalSm = max(
        (round(((inputHeightSm - fontSizeBase * lineHeightBase) / 2) * 10) / 10) - borderWidthBase, 0
    )
    public static var inputPaddingVerticalLg = (
        ceil(((inputHeightLg - fontSizeLg * lineHeightBase) / 2) * 10) / 10
    ) - borderWidthBase
    public static var inputPlaceholderColor: Color = .preferences(.inputPlaceholderColor)
    public static var inputColor = textColor
    public static var inputIconColor: Color = .preferences(.inputIconColor)
    public static var inputBorderColor = borderColorBase
    public static var inputBg: Color = .preferences(.inputBg)
    public static var inputNumberHoverBorderColor = inputHoverBorderColor
    public static var inputNumberHandlerActiveBg: Color = .preferences(.inputNumberHandlerActiveBg)
    public static var inputNumberHandlerHoverBg: Color = .base(primaryColorPalette, 5)
    public static var inputNumberHandlerBg = componentBackground
    public static var inputNumberHandlerBorderColor = borderColorBase
    public static var inputAddonBg = backgroundColorLight
    public static var inputHoverBorderColor: Color = .base(primaryColorPalette, 5)
    public static var inputDisabledBg = disabledBg
    public static var inputOutlineOffset: CGPoint = .init(x: 0, y: 0)
    public static var inputIconHoverColor: Color = .preferences(.inputIconHoverColor)
    public static var inputDisabledColor = disabledColor
    
    // Mentions
    // ---
    public static var mentionsDropdownBg = componentBackground
    public static var mentionsDropdownMenuItemHoverBg = mentionsDropdownBg
    
    // Select
    // ---
    public static var selectBorderColor = borderColorBase
    public static var selectItemSelectedColor = textColor
    public static var selectItemSelectedFontWeight: Font.Weight = .bold
    public static var selectDropdownBg = componentBackground
    public static var selectItemSelectedBg: Color = .base(primaryColorPalette, 1)
    public static var selectItemActiveBg = itemHoverBg
    public static var selectDropdownVerticalPadding = dropdownVerticalPadding
    public static var selectDropdownFontSize = dropdownFontSize
    public static var selectDropdownLineHeight = dropdownLineHeight
    public static var selectDropdownHeight: CGFloat = 32
    public static var selectBackground = componentBackground
    public static var selectClearBackground = selectBackground
    public static var selectSelectionItemBg = backgroundColorBase
    public static var selectSelectionItemBorderColor = borderColorSplit
    public static var selectSingleItemHeightLg: CGFloat = 40
    public static var selectMultipleItemHight = inputHeightBase - inputPaddingVerticalBase * 2
    public static var selectMultipleItemHeightLg: CGFloat = 32
    public static var selectMultipleItemSpacingHalf = ceil((inputPaddingVerticalBase / 2))
    public static var selectMultipleDisabledBackground = inputDisabledBg
    public static var selectMultipleItemDisabledColor: Color = .preferences(.selectMultipleItemDisabledColor)
    public static var selectMultipleItemDisabledBorderColor = selectBorderColor
    
    //Dropdown
    public static var dropdownMenuBg = componentBackground
    public static var dropdownVerticalPadding: CGFloat = 5
    public static var dropdownEdgeChildVerticalPadding: CGFloat = 4
    public static var dropdownFontSize = fontSizeBase
    public static var dropdownLineHeight: CGFloat = 22
    
    // Empty
    public static var emptyFontSize = fontSizeBase
    
    // Radio
    public static var radioSize: CGFloat = 16
    public static var radioTop = 0.2 * fontSizeBase
    public static var radioBorderWidth: CGFloat = 1
    public static var radioDotSize = radioSize - 8
    public static var radioDotColor = primaryColor
    public static var radioDotDisabledColor: Color = .preferences(.radioDotDisabledColor)
    public static var radioSolidCheckedColor: Color = .preferences(.radioSolidCheckedColor)
    
    // Radio buttons
    public static var radioButtonBg = btnDefaultBg
    public static var radioButtonCheckedBg = btnDefaultBg
    public static var radioButtonColor = btnDefaultColor
    public static var radioButtonHoverColor: Color = .base(primaryColorPalette, 5)
    public static var radioButtonActiveColor: Color = .base(primaryColorPalette, 7)
    public static var radioButtonPaddingHorizontal = paddingMd - 1
    public static var radioDisabledButtonCheckedBg: Color = .preferences(.radioDisabledButtonCheckedBg)
    public static var radioDisabledButtonCheckedColor = disabledColor
    public static var radioWrapperMarginRight: CGFloat = 8
    
    // Spin
    // ---
    public static var spinDotSizeSm: CGFloat = 14
    public static var spinDotSize: CGFloat = 20
    public static var spinDotSizeLg: CGFloat = 32
    
    // Table
    // --
    public static var tableBg = componentBackground
    public static var tableHeaderBg = backgroundColorLight
    public static var tableHeaderColor = headingColor
    public static var tableHeaderSortBg = backgroundColorBase
    public static var tableBodySortBg: Color = .preferences(.tableBodySortBg)
    public static var tableRowHoverBg = backgroundColorLight
    //    @table-selected-row-color: inherit;
    public static var tableSelectedRowBg: Color = .base(primaryColorPalette, 1)
    public static var tableBodySelectedSortBg = tableSelectedRowBg
    //    @table-selected-row-hover-bg: darken(@table-selected-row-bg, 2%);
    public static var tableExpandedRowBg: Color = .preferences(.tableExpandedRowBg)
    public static var tablePaddingVertical: CGFloat = 16
    public static var tablePaddingHorizontal: CGFloat = 16
    public static var tablePaddingVerticalMd = tablePaddingVertical * 3 / 4
    public static var tablePaddingHorizontalMd = tablePaddingHorizontal / 2
    public static var tablePaddingVerticalSm = tablePaddingVertical / 2
    public static var tablePaddingHorizontalSm = tablePaddingHorizontal / 2
    public static var tableBorderColor = borderColorSplit
    public static var tableBorderRadiusBase = borderRadiusBase
    public static var tableFooterBg = backgroundColorLight
    public static var tableFooterColor = headingColor
    public static var tableHeaderBgSm = tableHeaderBg
    public static var tableFontSize = fontSizeBase
    public static var tableFontSizeMd = tableFontSize
    public static var tableFontSizeSm = tableFontSize
    public static var tableHeaderCellSplitColor: Color = .preferences(.tableHeaderCellSplitColor)
    
    // Filter
    public static var tableExpandIconBg: Color = .preferences(.tableExpandIconBg)
}
