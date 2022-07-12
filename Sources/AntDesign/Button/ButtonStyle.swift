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

public struct ButtonGroup<Content>: View where Content: View {
    @State private var focusedIndex = 0
    private let views: [Content]
    
    public init(_ views: Content...) {
        self.views = views
    }
        
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(views.indices, id: \.self) { index in
                let gesture = DragGesture(minimumDistance: 0).onChanged { _ in
                    focusedIndex = index
                }
                
                views[index]
                    .zIndex(focusedIndex == index ? 10 : 1)
                    .environment(\.groupPosition, views.count == 1 ? .alone : index == views.indices.first ? .first : index == views.indices.last ? .last : .middle )
                    .simultaneousGesture(gesture)
            }
        }
    }
}
