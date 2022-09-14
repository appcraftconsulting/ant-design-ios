//
//  CheckboxToggleStyle.swift
//  
//
//  Created by François Boulais on 09/09/2022.
//

import SwiftUI

internal struct CheckboxToggleStyle: ToggleStyle {
    func isIndeterminate(configuration: Configuration) -> Bool {
        if #available(iOS 16.0, *) {
            return configuration.isMixed
        } else {
            return false
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
        }
        .buttonStyle(
            CheckboxButtonStyle(
                isOn: configuration.$isOn,
                isIndeterminate: isIndeterminate(configuration: configuration)
            )
        )
    }
}

fileprivate struct CheckboxButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var ringOpacity: CGFloat = 0
    @State private var ringScale: CGFloat = 1
    @Binding var isOn: Bool
    let isIndeterminate: Bool

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
            if isOn {
                return Preferences.checkboxColor
            } else {
                return Preferences.componentBackground
            }
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
    
    var indeterminateSize: CGFloat {
        Preferences.checkboxSize - 8
    }
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Preferences.checkboxBorderRadius)
                    .fill(fillColor)
                    .transition(.opacity)
                
                RoundedRectangle(cornerRadius: Preferences.checkboxBorderRadius)
                    .stroke(borderColor(isPressed: configuration.isPressed))
            }
            .frame(
                width: Preferences.checkboxSize,
                height: Preferences.checkboxSize
            )
            .background {
                RoundedRectangle(cornerRadius: Preferences.checkboxBorderRadius)
                    .stroke(Preferences.checkboxColor)
                    .scaleEffect(ringScale)
                    .opacity(ringOpacity)
            }
            .overlay {
                if isOn {
                    CheckboxShape()
                        .stroke(Preferences.checkboxCheckColor, lineWidth: 2)
                        .transition(.scale)
                        .animation(Preferences.easeOutBack, value: isOn)
                } else if isIndeterminate {
                    Rectangle()
                        .fill(Preferences.checkboxColor)
                        .padding(8)
                }
            }
            
            configuration.label
                .font(.system(size: Preferences.fontSizeBase))
                .foregroundColor(isEnabled ? Preferences.textColor : Preferences.disabledColor)
                .padding(.horizontal, 8)
            
            Spacer()
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

fileprivate struct CheckboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        let checkWidth = (Preferences.checkboxSize / 14) * 5
        let checkHeight = (Preferences.checkboxSize / 14) * 6
        
        var path = Path()
        
        path.move(to: .init(
            x: rect.width * 0.215,
            y: rect.height * 0.5
        ))
        
        if let currentPoint = path.currentPoint {
            path.addLine(to: .init(
                x: currentPoint.x + checkWidth * 0.5,
                y: currentPoint.y + checkHeight * 0.5
            ))
        }
        
        if let currentPoint = path.currentPoint {
            path.addLine(to: .init(
                x: currentPoint.x + checkWidth,
                y: currentPoint.y - checkHeight
            ))
        }

        return path
    }
}
