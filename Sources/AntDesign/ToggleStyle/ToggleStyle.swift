//
//  ToggleStyle.swift
//  
//
//  Created by François Boulais on 05/07/2022.
//

import SwiftUI

public struct ToggleStyle: SwiftUI.ToggleStyle {
    public enum Size {
        case small
        case `default`
    }
    
    @Environment(\.isEnabled) private var isEnabled
    @State private var outlinePadding: CGFloat = 0.0
    @State private var outlineOpacity: CGFloat = 0.5
    @State private var isPressed: Bool = false
    
    private let size: Size
    private let icon: Icon?
    
    public init(
        size: Size = .default,
        icon: Icon? = nil
    ) {
        self.size = size
        self.icon = icon
    }
    
    private var minWidth: CGFloat {
        switch size {
        case .default:
            return Preferences.switchMinWidth
        case .small:
            return Preferences.switchSmMinWidth
        }
    }
    
    private var height: CGFloat {
        switch size {
        case .default:
            return Preferences.switchHeight
        case .small:
            return Preferences.switchSmHeight
        }
    }
    
    private var pinSize: CGFloat {
        switch size {
        case .default:
            return Preferences.switchHeight - 4
        case .small:
            return Preferences.switchSmHeight - 4
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        var isOn: Bool { configuration.isOn }
        
        return HStack {
            configuration.label
            
            Spacer()
            
            Button {
                configuration.isOn.toggle()
            } label: {
                Group {
                    HStack(spacing: 0) {
                        if isOn {
                            Text("1")
                        } else {
                            Text("0")
                        }
                    }
                    .font(.system(size: Preferences.fontSizeSm))
                    .padding(.leading, isOn ? Preferences.switchInnerMarginMin : Preferences.switchInnerMarginMax)
                    .padding(.trailing, isOn ? Preferences.switchInnerMarginMax : Preferences.switchInnerMarginMin)
                }
                .padding(Preferences.switchPadding)
                .frame(height: height)
                .background {
                    Capsule()
                        .fill(isOn ? Preferences.switchColor : Preferences.disabledColor)
                        .opacity(isEnabled ? 1 : Preferences.switchDisabledOpacity)
                }
            }
            .background {
                ZStack {
                    Capsule()
                        .fill(Preferences.switchColor)
                        .padding(outlinePadding)
                        .opacity(outlineOpacity)
                        
                    Capsule()
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
            }
            .animation(.easeInOut(duration: 0.2), value: isOn)
            .buttonStyle(ButtonStyle(isOn: isOn, pinSize: pinSize))
            .onChange(of: isOn) { _ in tap() }
        }
    }
    
    // MARK: - Private functions
    
    private func tap() {
        let duration: TimeInterval = 0.4
        
        withAnimation(.easeOut(duration: duration / 2)) {
            outlinePadding = -6.0
        }
        
        withAnimation(.easeOut(duration: duration)) {
            outlineOpacity = 0.0
        }
        
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            outlinePadding = 0.0
            outlineOpacity = 0.5
        }
    }
    
    // MARK: - Button Style
    
    private struct ButtonStyle: SwiftUI.ButtonStyle {
        let isOn: Bool
        let pinSize: CGFloat
        
        func makeBody(configuration: Configuration) -> some View {
            var isPressed: Bool { configuration.isPressed }
            
            return ZStack(alignment: isOn ? .trailing : .leading) {
                configuration.label
                
                Capsule()
                    .fill(.white)
                    .frame(width: pinSize * (isPressed ? 1.3 : 1.0), height: pinSize)
                    .shadow(color: Preferences.switchShadowColor, radius: 4, x: 0, y: 2)
                    .padding(Preferences.switchPadding)
            }
            .compositingGroup()
            .animation(.easeInOut(duration: 0.2), value: isPressed)
        }
    }
}
