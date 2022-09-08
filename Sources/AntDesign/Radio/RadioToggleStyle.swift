//
//  RadioToggleStyle.swift
//  
//
//  Created by François Boulais on 08/09/2022.
//

import SwiftUI

internal struct RadioToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
        }
        .buttonStyle(RadioButtonStyle(isOn: configuration.$isOn))
    }
}

struct RadioButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding var isOn: Bool
    @State private var ringOpacity: CGFloat = 0
    @State private var ringScale: CGFloat = 1
    
    func borderColor(isOn: Bool) -> Color {
        if !isEnabled || !isOn {
            return Preferences.borderColorBase
        } else {
            return Preferences.radioDotColor
        }
    }
    
    var fillColor: Color {
        if isEnabled {
            return Preferences.componentBackground
        } else {
            return Preferences.inputDisabledBg
        }
    }
    
    var dotColor: Color {
        if isEnabled {
            return Preferences.radioDotColor
        } else {
            return Preferences.radioDotDisabledColor
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(fillColor)
                
                Circle()
                    .stroke(borderColor(isOn: isOn))
            }
            .frame(height: Preferences.radioSize)
            .background {
                Circle()
                    .stroke(Preferences.radioDotColor)
                    .scaleEffect(ringScale)
                    .opacity(ringOpacity)
            }
            .overlay {
                if isOn {
                    Circle()
                        .fill(dotColor)
                        .transition(.scale)
                        .frame(height: Preferences.radioDotSize)
                }
            }
            
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
        }
        .animation(.linear(duration: 0.3), value: isOn)
        .animation(.linear(duration: 0.3), value: isEnabled)
        .onChange(of: isOn) { isOn in
            /// `onTap` would be better but conflicts with button `action`
            if isOn { tap() }
        }
    }
    
    private func tap() {
        let duration: TimeInterval = 0.36
        
        ringOpacity = 0.5
        ringScale = 1.0
        
        withAnimation(.linear(duration: duration)) {
            ringOpacity = 0.0
            ringScale = 1.6
        }
    }
}
