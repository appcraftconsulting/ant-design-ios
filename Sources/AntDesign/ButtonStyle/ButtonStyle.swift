//
//  ButtonStyle.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct ButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.isEnabled) internal var isEnabled: Bool
    @State internal var isHovered: Bool = false
    @State private var outlinePadding: CGFloat = 0.0
    @State private var outlineOpacity: CGFloat = 0.5
    
    internal let type: ButtonType
    internal let shape: ButtonShape
    internal let layout: ButtonLayout
    internal let size: Size
    
    internal let block: Bool
    internal let ghost: Bool
    internal let loading: Bool
    
    public init(
        type: ButtonType = .default,
        shape: ButtonShape = .default,
        layout: ButtonLayout = .default,
        size: Size = .default,
        block: Bool = false,
        ghost: Bool = false,
        loading: Bool = false
    ) {
        self.type = type
        self.shape = shape
        self.layout = layout
        self.size = size
        self.block = block
        self.ghost = ghost
        self.loading = loading
    }

    private var cornerRadius: CGFloat {
        switch (shape, size) {
        case (.default, .middle), (.default, .large), (.square, .middle), (.square, .large):
            return Preferences.btnBorderRadiusBase
        case (.default, .small), (.square, .small):
            return Preferences.btnBorderRadiusSm
        case (.circle, .small), (.round, .small):
            return Preferences.btnCircleSizeSm / 2
        case (.circle, .middle), (.round, .middle):
            return Preferences.btnCircleSize / 2
        case (.circle, .large), (.round, .large):
            return Preferences.btnCircleSizeLg / 2
        }
    }
    
    private var height: CGFloat? {
        switch (shape, size) {
        case (.default, .small), (.round, .small):
            return Preferences.btnHeightSm
        case (.default, .middle), (.round, .middle):
            return Preferences.btnHeightBase
        case (.default, .large), (.round, .large):
            return Preferences.btnHeightLg
        case (.circle, .small):
            return Preferences.btnCircleSizeSm
        case (.circle, .middle):
            return Preferences.btnCircleSize
        case (.circle, .large):
            return Preferences.btnCircleSizeLg
        case (.square, .small):
            return Preferences.btnSquareSizeSm
        case (.square, .middle):
            return Preferences.btnSquareSize
        case (.square, .large):
            return Preferences.btnSquareSizeLg
        }
    }
    
    private var width: CGFloat? {
        switch (shape, size) {
        case (.default, _), (.round, _):
            return nil
        case (.circle, .small):
            return Preferences.btnCircleSizeSm
        case (.circle, .middle):
            return Preferences.btnCircleSize
        case (.circle, .large):
            return Preferences.btnCircleSizeLg
        case (.square, .small):
            return Preferences.btnSquareSizeSm
        case (.square, .middle):
            return Preferences.btnSquareSize
        case (.square, .large):
            return Preferences.btnSquareSizeLg
        }
    }
    
    private var horizontalPadding: CGFloat {
        switch (size, shape) {
        case (.small, .default), (.small, .round):
            return Preferences.btnPaddingHorizontalSm
        case (.middle, .default), (.middle, .round):
            return Preferences.btnPaddingHorizontalBase
        case (.large, .default), (.large, .round):
            return Preferences.btnPaddingHorizontalLg
        case (_, .circle), (_, .square):
            return 0
        }
    }

    private var borderDash: [CGFloat]? {
        switch type {
        case .default:
            return []
        case .dashed:
            return [4]
        case .primary, .text, .link:
            return nil
        }
    }
    
    private func backgroundShadow(isPressed: Bool) -> Shadow? {
        guard isEnabled && !isPressed else { return nil }
        
        switch type {
        case .primary:
            return Preferences.btnPrimaryShadow
        case .default, .dashed:
            return Preferences.btnShadow
        default:
            return nil
        }
    }
    
    private var titleShadow: Shadow? {
        guard isEnabled && !ghost else { return nil }

        switch type {
        case .primary:
            return Preferences.btnTextShadow
         case .default, .dashed, .text, .link:
            return nil
        }
    }
    
    private func outlineColor(danger: Bool) -> Color? {
        guard (type == .primary || type == .default || type == .dashed) && !loading else {
            return nil
        }
        
        return danger ? Preferences.btnDangerBg : Preferences.btnPrimaryBg
    }
    
    private func color(from interactive: Attributes.InteractiveColor, isPressed: Bool) -> Color {
        if isHovered {
            return interactive.hovered
        } else if isPressed {
            return interactive.pressed
        } else {
            return interactive.idle
        }
    }
            
    public func makeBody(configuration: Configuration) -> some View {
        var danger: Bool { configuration.role == .destructive }
        var isPressed: Bool { configuration.isPressed }
        
        return configuration.label
            .labelStyle(ContentLabelStyle(layout: layout, size: size, loading: loading, titleShadow: titleShadow))
            .foregroundColor(color(from: attributes(danger: danger).foregroundColor, isPressed: isPressed))
            .font(.system(size: size.font).weight(Preferences.btnFontWeight))
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: block ? .infinity : nil)
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color(from: attributes(danger: danger).backgroundColor, isPressed: isPressed))
                    .modifier(ShadowModifier(shadow: backgroundShadow(isPressed: isPressed)))
            }
            .background {
                if let outlineColor = outlineColor(danger: danger) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius + abs(outlinePadding))
                            .fill(outlineColor)
                            .padding(outlinePadding)
                            .opacity(outlineOpacity)
                            
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .blendMode(.destinationOut)
                    }
                }
            }
            .overlay {
                if let borderColor = attributes(danger: danger).borderColor, let borderStyle = attributes(danger: danger).borderStyle {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            color(from: borderColor, isPressed: isPressed),
                            style: .init(lineWidth: Preferences.btnBorderWidth, dash: borderStyle.dash)
                        )
                }
            }
            .compositingGroup()
            .opacity(loading ? 0.65 : 1)
            .onHover { isHovered = $0 }
//            .onTapGesture { tap() }
            .animation(.linear(duration: 0.1), value: isPressed)
            .animation(.linear(duration: 0.1), value: isHovered)
            .animation(.linear(duration: 0.1), value: isEnabled)
            .animation(.linear(duration: 0.1), value: loading)
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
}

// MARK: - Styles

internal struct ContentLabelStyle: LabelStyle {
    let layout: ButtonLayout
    let size: Size
    let loading: Bool
    let titleShadow: Shadow?
    
    @State private var spin: CGFloat = 0
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            HStack {
                Group {
                    if loading {
                        IconView(icon: .outlined(.loading), size: size, spin: true)
                    } else if layout.hasIcon {
                        configuration.icon
                    }
                }
                .frame(width: size.icon.width, height: size.icon.height)
                
                if layout.hasTitle {
                    configuration.title
                        .modifier(ShadowModifier(shadow: titleShadow))
                }
            }
        }
    }
}
