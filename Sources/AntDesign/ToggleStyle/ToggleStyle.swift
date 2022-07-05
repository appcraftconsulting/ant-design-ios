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
    
    public init(size: Size = .default) {
        self.size = size
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
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Button {
                configuration.isOn.toggle()
            } label: {
                Capsule()
                    .fill(configuration.isOn ? Preferences.switchColor : Preferences.disabledColor)
                    .opacity(isEnabled ? 1 : Preferences.switchDisabledOpacity)
                    .frame(width: minWidth)
                    .frame(height: height)
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
            .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            .buttonStyle(ButtonStyle(isOn: configuration.isOn, size: size))
            .onChange(of: configuration.isOn) { _ in
                tap()
            }
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
        let size: Size
        
        private var pinSize: CGFloat {
            switch size {
            case .default:
                return Preferences.switchHeight - 4
            case .small:
                return Preferences.switchSmHeight - 4
            }
        }
        
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
