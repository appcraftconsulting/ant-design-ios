//
//  Button.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct Button: ButtonStyle {
    enum `Type` {
        case primary
        case `default`
        case dashed
        case text
        case link
    }
    
    enum Shape {
        enum Content {
            case icon, title
        }
        
        case `default`
        case round
        case circle(Content)
        case square(Content)
    }
    
    enum Icon: String {
        case test
        
        var name: String {
            rawValue
        }
    }
    
    var type: `Type` = .default
    var size: Size = .default
    var shape: Shape = .default
    
    var block: Bool = false
    var danger: Bool = false
    var ghost: Bool = false
    var loading: Bool = false
                    
    func makeBody(configuration: Configuration) -> some View {
        ContentView(
            configuration: configuration,
            type: type,
            size: size,
            shape: shape,
            block: block,
            danger: danger,
            ghost: ghost,
            loading: loading
        )
    }
    
    struct ContentView: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        let type: `Type`
        let size: Size
        let shape: Shape

        let block: Bool
        let danger: Bool
        let ghost: Bool
        let loading: Bool

        @State private var isHovered: Bool = false

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
            switch size {
            case .small:
                return Preferences.btnPaddingHorizontalSm
            case .middle:
                return Preferences.btnPaddingHorizontalBase
            case .large:
                return Preferences.btnPaddingHorizontalLg
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
        
        private var backgroundShadow: Shadow? {
            guard isEnabled && !configuration.isPressed else { return nil }
            
            switch type {
            case .primary:
                return .init(color: .black.opacity(0.045), offset: .init(x: 0, y: 2 + Preferences.btnBorderWidth))
            case .default, .dashed:
                return .init(color: .black.opacity(0.015), offset: .init(x: 0, y: 2 + Preferences.btnBorderWidth))
            default:
                return nil
            }
        }
        
        private var titleShadow: Shadow? {
            guard isEnabled && !ghost else { return nil }

            switch type {
            case .primary:
                return .init(color: .black.opacity(0.12), offset: .init(x: 0, y: -1))
             case .default, .dashed, .text, .link:
                return nil
            }
        }
        
        private var attributes: Attributes {
            switch (type, ghost, danger, isEnabled) {
            case (.primary, false, false, true):
                return .primary
            case (.primary, true, false, true):
                return .primaryGhost
            case (.primary, false, true, true):
                return .primaryDanger
            case (.primary, true, true, true):
                return .primaryGhostDanger
            case (.primary, _, _, false):
                return .primaryDisabled
                
            case (.default, false, false, true):
                return .default
            case (.default, true, false, true):
                return .defaultGhost
            case (.default, false, true, true):
                return .defaultDanger
            case (.default, true, true, true):
                return .defaultGhostDanger
            case (.default, _, _, false):
                return .defaultDisabled
            default:
                fatalError()
            }
        }
        
        var body: some View {
            configuration.label
                .labelStyle(ContentLabelStyle(shape: shape, loading: loading, titleShadow: titleShadow))
                .foregroundColor(configuration.isPressed ? attributes.foregroundColor.pressed : isHovered ? attributes.foregroundColor.hovered : attributes.foregroundColor.idle)
                .font(.body)
                .padding(.horizontal, horizontalPadding)
                .frame(maxWidth: block ? .infinity : nil)
                .frame(width: width, height: height)
                .background {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(configuration.isPressed ? attributes.backgroundColor.pressed : isHovered ? attributes.backgroundColor.hovered : attributes.backgroundColor.idle)
                        .modifier(ShadowModifier(shadow: backgroundShadow))
                }
                .overlay {
                    if let borderColor = attributes.borderColor, let borderStyle = attributes.borderStyle {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(
                                configuration.isPressed ? borderColor.pressed : isHovered ? borderColor.hovered : borderColor.idle,
                                style: .init(lineWidth: Preferences.borderWidthBase, dash: borderStyle.dash)
                            )
                    }
                }
                .onHover { isHovered = $0 }
                .animation(.linear(duration: 0.1), value: configuration.isPressed)
                .animation(.linear(duration: 0.1), value: isHovered)
                .animation(.linear(duration: 0.1), value: isEnabled)
        }
    }
    
    // MARK: - Styles
    
    struct ContentLabelStyle: LabelStyle {
        let shape: Shape
        let loading: Bool
        let titleShadow: Shadow?

        func makeBody(configuration: Configuration) -> some View {
            switch shape {
            case .default, .round:
                HStack {
                    if loading {
                        LoadingView()
                    } else {
                        configuration.icon
                    }
                    
                    configuration.title
                        .modifier(ShadowModifier(shadow: titleShadow))
                }
            case let .circle(content), let .square(content):
                if loading {
                    LoadingView()
                } else if content == .icon {
                    configuration.icon
                } else if content == .title {
                    configuration.title
                }
            }
        }
    }
}
