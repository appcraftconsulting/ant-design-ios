//
//  InputTextFieldStyle.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct InputTextFieldStyle: TextFieldStyle {
    @Environment(\.componentSize) internal var size: ComponentSize
    @Environment(\.inputStatus) internal var inputStatus: InputStatus?
    @FocusState var isFocused: Bool
    
    private let systemName: String?
    private let isHovered: Bool
    private let status: InputStatus?
    
    public init(
        systemName: String? = nil,
        isHovered: Bool = false,
        status: InputStatus? = nil
    ) {
        self.systemName = systemName
        self.isHovered = isHovered
        self.status = status
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
    
    private var borderColor: Color {
        if let status = status ?? inputStatus {
            switch status {
            case .error:
                return Preferences.errorColor
            case .warning:
                return Preferences.warningColor
            }
        } else {
            return Preferences.primaryColor
        }
    }
    
    private var outlineColor: Color {
        if let status = status ?? inputStatus {
            switch status {
            case .error:
                return Preferences.errorColorOutline
            case .warning:
                return Preferences.warningColorOutline
            }
        } else {
            return Preferences.primaryColorOutline
        }
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let systemName = systemName {
                Image(systemName: systemName)
            }
            
            configuration
                .textFieldStyle(.plain)
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
                        .stroke(borderColor, lineWidth: Preferences.borderWidthBase)
                        .overlay {
                            RoundedRectangle(cornerRadius: Preferences.borderRadiusBase + Preferences.outlineWidth / 2)
                                .stroke(outlineColor, lineWidth: Preferences.outlineWidth)
                                .padding(-(Preferences.outlineWidth / 2 + Preferences.borderWidthBase / 2))
                        }
                } else if isHovered {
                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                        .stroke(Preferences.primaryColor, lineWidth: Preferences.borderWidthBase)
                } else {
                    if let status = status ?? inputStatus {
                        RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                            .stroke(status.color, lineWidth: Preferences.borderWidthBase)
                    } else {
                        RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                            .stroke(Preferences.inputBorderColor, lineWidth: Preferences.borderWidthBase)
                    }
                }
            }
        }
        .animation(.default, value: isHovered)
        .animation(.default, value: isFocused)
        .contentShape(RoundedRectangle(cornerRadius: Preferences.borderRadiusBase))
    }
}
