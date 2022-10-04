//
//  SwitchToggleStyle.swift
//  
//
//  Created by François Boulais on 05/07/2022.
//

import SwiftUI

public struct SwitchToggleStyle: SwiftUI.ToggleStyle {
    public enum Size {
        case small
        case `default`
        
        var loadingIcon: CGSize {
            switch self {
            case .small:
                return .init(width: 9, height: 9)
            case .default:
                return .init(width: 14, height: 14)
            }
        }
        
        var minWidth: CGFloat {
            switch self {
            case .default:
                return Preferences.switchMinWidth
            case .small:
                return Preferences.switchSmMinWidth
            }
        }
        
        var height: CGFloat {
            switch self {
            case .default:
                return Preferences.switchHeight
            case .small:
                return Preferences.switchSmHeight
            }
        }
        
        var pin: CGFloat {
            switch self {
            case .default:
                return Preferences.switchHeight - 4
            case .small:
                return Preferences.switchSmHeight - 4
            }
        }
    }
    
    public enum Child {
        case icon(Icon)
        case text(String)
    }
    
    @Environment(\.isEnabled) private var isEnabled

    @State private var outlinePadding: CGFloat = 0.0
    @State private var outlineOpacity: CGFloat = 0.5
    @State private var isPressed: Bool = false
    
    private let size: Size
    private let checkedChild: Child?
    private let unCheckedChild: Child?
    private let isLoading: Bool
    
    private let generator = UIImpactFeedbackGenerator(style: .light)

    public init(
        size: Size = .default,
        checkedChild: Child? = nil,
        unCheckedChild: Child? = nil,
        isLoading: Bool = false
    ) {
        self.size = size
        self.checkedChild = checkedChild
        self.unCheckedChild = unCheckedChild
        self.isLoading = isLoading
    }
    
    private func child(isOn: Bool) -> Child? {
        if isOn {
            return checkedChild
        } else {
            return unCheckedChild
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        var isOn: Bool { configuration.isOn }
        
        return HStack(spacing: Preferences.paddingXs) {
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn.toggle()
                }
            } label: {
                Group {
                    if let child = child(isOn: isOn) {
                        Group {
                            switch child {
                            case let .icon(icon):
                                IconView(
                                    icon: icon,
                                    size: .init(width: 12, height: 12)
                                )
                            case let .text(string):
                                Text(string)
                                    .font(.system(size: Preferences.fontSizeSm))
                            }
                        }
                        .foregroundColor(Preferences.textColorInverse)
                        .padding(.leading, isOn ? Preferences.switchInnerMarginMin : Preferences.switchInnerMarginMax)
                        .padding(.trailing, isOn ? Preferences.switchInnerMarginMax : Preferences.switchInnerMarginMin)
                        .padding(Preferences.switchPadding)
                    } else {
                        Color.clear
                    }
                }
                .frame(minWidth: size.minWidth, idealHeight: size.height)
                .fixedSize(horizontal: true, vertical: true)
                .background {
                    Capsule()
                        .fill(isOn ? Preferences.switchColor : Preferences.disabledColor)
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
            .buttonStyle(ButtonStyle(isOn: isOn, isLoading: isLoading, size: size))
            .disabled(isLoading)
            .onAppear() {
                generator.prepare()
            }
            .onChange(of: isOn) { _ in
                tap()
            }
        }
    }
    
    // MARK: - Private functions
    
    private func tap() {
        generator.impactOccurred()
        
        let duration: TimeInterval = 0.4
        
        withAnimation(.easeOut(duration: duration / 2)) {
            outlinePadding = -4.0
        }
        
        withAnimation(.easeOut(duration: duration)) {
            outlineOpacity = 0.0
        }
        
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            outlinePadding = 0.0
            outlineOpacity = 0.5
        }
    }
    
    // MARK: - Styles
    
    private struct ButtonStyle: SwiftUI.ButtonStyle {
        @Environment(\.isEnabled) private var isEnabled
        
        let isOn: Bool
        let isLoading: Bool
        let size: Size
        
        func makeBody(configuration: Configuration) -> some View {
            var isPressed: Bool { configuration.isPressed }
            
            return ZStack(alignment: isOn ? .trailing : .leading) {
                configuration.label
                
                ZStack(alignment: .center) {
                    Capsule()
                        .fill(Preferences.switchBg)
                        .frame(width: size.pin * (isPressed ? 1.3 : 1.0), height: size.pin)
                        .shadow(color: Preferences.switchShadowColor, radius: 4, x: 0, y: 2)
                        .padding(Preferences.switchPadding)
                    
                    if isLoading {
                        IconView(
                            icon: .outlined(.loading),
                            size: size.loadingIcon,
                            spin: true
                        )
                        .foregroundColor(isOn ? Preferences.switchColor : .black.opacity(0.65))
                    }
                }
            }
            .compositingGroup()
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .opacity(isEnabled ? 1 : Preferences.switchDisabledOpacity)
        }
    }
}
