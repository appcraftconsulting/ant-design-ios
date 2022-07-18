//
//  PrepareMessageModifier.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import SwiftUI

internal struct PrepareMessageModifier: ViewModifier {
    @EnvironmentObject var manager: MessageManager

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            VStack {
                ForEach(manager.messages, id: \.key) { message in
                    MessageView(message: message)
                }
            }
        }
        .animation(.default, value: manager.messages)
    }
}

public extension View {
    func prepareMessage() -> some View {
        modifier(PrepareMessageModifier())
            .environmentObject(MessageManager())
    }
}
