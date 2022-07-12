//
//  MessageView.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import SwiftUI

internal struct MessageView: View {
    let message: Message

    var body: some View {
        Label {
            Text(message.text)
                .font(.system(size: Preferences.fontSizeBase))
                .foregroundColor(Preferences.textColor)
                .multilineTextAlignment(.center)
        } icon: {
            switch message.type {
            case .success:
                IconView(icon: .filled(.checkCircle))
                    .foregroundColor(Preferences.successColor)
            case .error:
                IconView(icon: .filled(.closeCircle))
                    .foregroundColor(Preferences.errorColor)
            case .warning:
                IconView(icon: .filled(.exclamationCircle))
                    .foregroundColor(Preferences.warningColor)
            case .info:
                IconView(icon: .filled(.infoCircle))
                    .foregroundColor(Preferences.infoColor)
            case .loading:
                IconView(icon: .outlined(.loading), spin: true)
                    .foregroundColor(Preferences.primaryColor)
            }
            
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
