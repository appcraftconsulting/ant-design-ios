//
//  MenuStyle.swift
//  
//
//  Created by François Boulais on 11/07/2022.
//

import SwiftUI

public struct MenuStyle: SwiftUI.MenuStyle {
    internal let type: ButtonType
    internal let shape: ButtonShape
    internal let layout: ButtonLayout
    
    internal let isBlock: Bool
    internal let isGhost: Bool
    internal let isLoading: Bool
        
    public init(
        type: ButtonType = .default,
        shape: ButtonShape = .default,
        layout: ButtonLayout = .default,
        isBlock: Bool = false,
        isGhost: Bool = false,
        isLoading: Bool = false
    ) {
        self.type = type
        self.shape = shape
        self.layout = layout
        self.isBlock = isBlock
        self.isGhost = isGhost
        self.isLoading = isLoading
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .modifier(ButtonModifier(
                type: type,
                shape: shape,
                layout: layout,
                isGhost: isGhost,
                isBlock: isBlock,
                isLoading: isLoading,
                isDanger: false,
                isPressed: false
            ))
    }
}
