//
//  InputTextFieldStyle.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct InputTextFieldStyle: TextFieldStyle {
    @Environment(\.componentSize) internal var size: ComponentSize
    @FocusState var isFocused: Bool

    public let systemName: String?
    public let isHovered: Bool
    
    public init(
        systemName: String? = nil,
        isHovered: Bool = false
    ) {
        self.systemName = systemName
        self.isHovered = isHovered
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small:
            return Preferences.inputPaddingVerticalSm
        case .middle:
            return Preferences.inputPaddingVerticalBase
        case .large:
            return Preferences.inputPaddingVerticalLg
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small:
            return Preferences.inputPaddingHorizontalSm
        case .middle:
            return Preferences.inputPaddingHorizontalBase
        case .large:
            return Preferences.inputPaddingHorizontalLg
        }
    }
    
    private var height: CGFloat {
        switch size {
        case .small:
            return Preferences.inputHeightSm
        case .middle:
            return Preferences.inputHeightBase
        case .large:
            return Preferences.inputHeightLg
        }
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let systemName = systemName {
                Image(systemName: systemName)
            }
            
            configuration
                .focused($isFocused)
        }
        .font(.system(size: Preferences.fontSizeBase))
        .foregroundColor(Preferences.inputColor)
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .frame(height: height)
        .background {
            Group {
                if isFocused {
                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                        .stroke(Preferences.primaryColor, lineWidth: Preferences.borderWidthBase)
                        .overlay {
                            RoundedRectangle(cornerRadius: Preferences.borderRadiusBase + Preferences.outlineWidth / 2)
                                .stroke(Preferences.primaryColorOutline, lineWidth: Preferences.outlineWidth)
                                .padding(-(Preferences.outlineWidth / 2 + Preferences.borderWidthBase / 2))
                        }
                } else if isHovered {
                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                        .stroke(Preferences.primaryColor, lineWidth: Preferences.borderWidthBase)
                } else {
                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                        .stroke(Preferences.inputBorderColor, lineWidth: Preferences.borderWidthBase)
                }
            }
            .animation(.default, value: isFocused)
            .animation(.default, value: isHovered)
        }
        .contentShape(RoundedRectangle(cornerRadius: Preferences.borderRadiusBase))
    }
}
