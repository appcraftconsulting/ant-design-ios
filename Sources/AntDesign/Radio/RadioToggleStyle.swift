//
//  RadioToggleStyle.swift
//  
//
//  Created by François Boulais on 08/09/2022.
//

import SwiftUI

public struct RadioToggleStyle: ToggleStyle {
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
        }
        .buttonStyle(RadioButtonStyle(isOn: configuration.$isOn))
    }
}

internal struct RadioButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var ringOpacity: CGFloat = 0
    @State private var ringScale: CGFloat = 1
    @Binding var isOn: Bool
    
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    func borderColor(isPressed: Bool) -> Color {
        if (isOn && isEnabled) || isPressed {
            return Preferences.radioDotColor
        } else {
            return Preferences.borderColorBase
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
    
    public func makeBody(configuration: Configuration) -> some View {
        return HStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(fillColor)
                
                Circle()
                    .stroke(borderColor(isPressed: configuration.isPressed))
            }
            .frame(
                width: Preferences.radioSize,
                height: Preferences.radioSize
            )
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
                .font(.system(size: Preferences.fontSizeBase))
                .foregroundColor(isEnabled ? Preferences.textColor : Preferences.disabledColor)
                .padding(.horizontal, 8)
        }
        
        .animation(.linear(duration: 0.3), value: isOn)
        .animation(.linear(duration: 0.3), value: isEnabled)
        .onAppear() {
            generator.prepare()
        }
        .onChange(of: isOn) { isOn in
            /// `onTap` would be better but conflicts with button `action`
            generator.impactOccurred()
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
