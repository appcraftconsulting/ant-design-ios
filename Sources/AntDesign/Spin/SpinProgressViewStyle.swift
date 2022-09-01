//
//  SpinProgressViewStyle.swift
//  
//
//  Created by François Boulais on 01/09/2022.
//

import SwiftUI

public struct SpinProgressViewStyle: ProgressViewStyle {
    public enum Size {
        case small
        case middle
        case large
        
        public static let `default`: Self = .middle
    }
    
    private var spinSize: CGFloat {
        switch size {
        case .small:
            return Preferences.spinDotSizeSm
        case .middle:
            return Preferences.spinDotSize
        case .large:
            return Preferences.spinDotSizeLg
        }
    }
    
    @State private var angle: Angle = .radians(0)
    private let size: Size
    
    public init(size: Size = .default) {
        self.size = size
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Dot(index: 1, size: size)
                Spacer(minLength: 0)
                Dot(index: 2, size: size)
            }
            
            Spacer(minLength: 0)

            HStack(spacing: 0) {
                Dot(index: 3, size: size)
                Spacer(minLength: 0)
                Dot(index: 4, size: size)
            }
        }
        .frame(width: spinSize, height: spinSize)
        .foregroundColor(Preferences.primaryColor)
        .rotationEffect(angle)
        .animation(.linear(duration: 1.2).repeatForever(autoreverses: false), value: angle)
        .onAppear {
            angle = .radians(2 * .pi)
        }
    }
    
    struct Dot: View {
        let index: Int
        let size: Size

        @State private var opacity: CGFloat = 0.3
        
        private var frame: CGSize {
            switch size {
            case .small:
                return .init(width: 6, height: 6)
            case .middle:
                return .init(width: 9, height: 9)
            case .large:
                return .init(width: 14, height: 14)
            }
        }
        
        private var animationDelay: TimeInterval {
            switch index {
            case 1:
                return 0.0
            case 2:
                return 0.4
            case 3:
                return 0.8
            case 4:
                return 1.2
            default:
                return 0.0
            }
        }
        
        var body: some View {
            Circle()
                .frame(width: frame.width, height: frame.height)
                .scaleEffect(0.75)
                .opacity(opacity)
                .animation(.linear(duration: 1).repeatForever(autoreverses: true).delay(animationDelay), value: opacity)
                .onAppear {
                    opacity = 1
                }
        }
    }
}
