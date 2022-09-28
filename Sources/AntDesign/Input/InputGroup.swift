//
//  InputGroup.swift
//  
//
//  Created by François Boulais on 27/09/2022.
//

import SwiftUI

public struct InputGroup<Content>: View where Content : View {
    @StateObject private var manager = InputGroupManager()
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                content.environment(\.inputGroupManager, manager)
            }
            
            if let message = manager.mostRecentMessage {
                Text(message.text)
                    .modifier(ExplainModifier(status: message.status))
            }
        }
    }
}
