//
//  Input.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

//public struct Input: TextFieldStyle {
//    public let size: ComponentSize
//    public let systemName: String?
//    public let isFocused: Bool
//    public let isHovered: Bool
//    
//    public init(
//        size: ComponentSize = .default,
//        systemName: String? = nil,
//        isFocused: Bool = false,
//        isHovered: Bool = false
//    ) {
//        self.size = size
//        self.systemName = systemName
//        self.isFocused = isFocused
//        self.isHovered = isHovered
//    }
//
//    public func _body(configuration: TextField<Self._Label>) -> some View {
//        HStack {
//            if let systemName = systemName {
//                Image(systemName: systemName)
//            }
//            
//            configuration
//        }
//        .padding()
//        .foregroundColor(.neutral(.primaryText))
//        .frame(height: 40)
//        .background {
//            Group {
//                if isFocused {
//                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
//                        .stroke(Preferences.primaryColor, lineWidth: Preferences.borderWidthBase)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: Preferences.borderRadiusBase + Preferences.outlineWidth / 2)
//                                .stroke(Preferences.primaryColorOutline, lineWidth: Preferences.outlineWidth)
//                                .padding(-(Preferences.outlineWidth / 2 + Preferences.borderWidthBase / 2))
//                        }
//                } else if isHovered {
//                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
//                        .stroke(Preferences.primaryColor, lineWidth: Preferences.borderWidthBase)
//                } else {
//                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
//                        .stroke(Color.neutral(.border), lineWidth: Preferences.borderWidthBase)
//                }
//            }
//            .animation(.default, value: isFocused)
//            .animation(.default, value: isHovered)
//        }
//    }
//}
