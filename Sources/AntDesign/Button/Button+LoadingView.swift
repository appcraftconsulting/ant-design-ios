//
//  Button+LoadingView.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

internal extension Button {
    struct LoadingView: View {
        struct LoadingOutlined: SwiftUI.Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                
                path.addArc(
                    center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .radians(3 * .pi / 2),
                    endAngle: .radians(0),
                    clockwise: false
                )

                return path
            }
        }
        
        @State private var spin: CGFloat = 0
        
        var body: some View {
            LoadingOutlined()
                .stroke(style: .init(lineWidth: 1, lineCap: .round))
                .frame(width: 14, height: 14)
                .rotationEffect(.degrees(spin))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: spin)
                .onAppear { spin = 360 }
        }
    }
}
