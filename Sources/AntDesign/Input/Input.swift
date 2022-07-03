//
//  Input.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct Input: TextFieldStyle {
    var size: Size = .default
    var systemName: String?
    var isFocused: Bool
    var isHovered: Bool = false

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let systemName = systemName {
                Image(systemName: systemName)
            }
            
            configuration
        }
        .padding()
        .foregroundColor(.neutral(.primaryText))
        .frame(height: 40)
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
                        .stroke(Color.neutral(.border), lineWidth: Preferences.borderWidthBase)
                }
            }
            .animation(.default, value: isFocused)
            .animation(.default, value: isHovered)
        }
    }
}
