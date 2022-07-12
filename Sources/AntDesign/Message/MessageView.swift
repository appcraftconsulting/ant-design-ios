//
//  MessageView.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import SwiftUI

internal struct MessageView: View {
    let message: Message

    private var icon: Icon {
        switch message.type {
        case .success:
            return .filled(.checkCircle)
        case .error:
            return .filled(.closeCircle)
        case .warning:
            return .filled(.exclamationCircle)
        case .info:
            return .filled(.infoCircle)
        case .loading:
            return .outlined(.loading)
        }
    }
    
    private var iconColor: Color {
        switch message.type {
        case .success:
            return Preferences.successColor
        case .error:
            return Preferences.errorColor
        case .warning:
            return Preferences.warningColor
        case .info:
            return Preferences.infoColor
        case .loading:
            return Preferences.primaryColor
        }
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            IconView(icon: icon, spin: message.type == .loading)
                .foregroundColor(iconColor)
            
            Text(message.text)
                .font(.system(size: Preferences.fontSizeBase))
                .foregroundColor(Preferences.textColor)
                .multilineTextAlignment(.center)
        }
        .padding(Preferences.messageNoticeContentPadding)
        .background {
            RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                .fill(Preferences.messageNoticeContentBg)
        }
        .componentSize(.middle)
        .modifier(ShadowModifier(shadow: .shadow2))
        .transition(.move(edge: .top).combined(with: .opacity))
        .padding(.top, 8)
        .padding(.horizontal)
    }
    
    struct ShadowModifier: ViewModifier {
        @Environment(\.colorScheme) var colorScheme: ColorScheme
        
        enum Shadow {
            case shadow2
        }
        
        let shadow: Shadow
        
        func body(content: Content) -> some View {
            switch (shadow, colorScheme) {
            case (.shadow2, .light):
                content
                    .shadow(color: .black.opacity(0.12), radius: 06, x: 0, y: 3)
                    .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 6)
                    .shadow(color: .black.opacity(0.05), radius: 28, x: 0, y: 9)
            case (.shadow2, .dark):
                content
                    .shadow(color: .black.opacity(0.48), radius: 06, x: 0, y: 3)
                    .shadow(color: .black.opacity(0.32), radius: 16, x: 0, y: 6)
                    .shadow(color: .black.opacity(0.20), radius: 28, x: 0, y: 9)
            case (_, _):
                content
            }
        }
    }
}
