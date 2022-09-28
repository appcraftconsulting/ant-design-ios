//
//  ButtonStyle.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

public struct ButtonStyle: SwiftUI.ButtonStyle {
    internal let type: ButtonType
    internal let shape: ButtonShape
    internal let layout: ButtonLayout
    
    internal let isGhost: Bool
    internal let isBlock: Bool
    internal let isLoading: Bool
    
    public init(
        type: ButtonType = .default,
        shape: ButtonShape = .default,
        layout: ButtonLayout = .default,
        isGhost: Bool = false,
        isBlock: Bool = false,
        isLoading: Bool = false
    ) {
        self.type = type
        self.shape = shape
        self.layout = layout
        self.isBlock = isBlock
        self.isGhost = isGhost
        self.isLoading = isLoading
    }
    
    @State private var zIndex: CGFloat = 0
    
    public func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .modifier(ButtonModifier(
                type: type,
                shape: shape,
                layout: layout,
                isGhost: isGhost,
                isBlock: isBlock,
                isLoading: isLoading,
                isDanger: configuration.role == .destructive,
                isPressed: configuration.isPressed
            ))
    }
}
