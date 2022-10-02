//
//  MessageModifier.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import Foundation
import SwiftUI

internal struct MessageModifier: ViewModifier {
    @EnvironmentObject var manager: MessageManager
    @Binding var isPresented: Bool
    
    private let id = UUID().uuidString

    let type: MessageType
    let text: String
    let duration: TimeInterval?
    let key: String?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { isPresented in
                if isPresented {
                    manager.presentMessage(
                        with: id,
                        type: type,
                        text: text,
                        duration: duration,
                        key: key ?? UUID().uuidString
                    )
                } else {
                    manager.destroyMessage(with: id)
                }
            }
            .onReceive(manager.hasMessage(with: id)) { hasMessage in
                if isPresented != hasMessage {
                    isPresented = hasMessage
                }
            }
            .onDisappear {
                manager.destroyMessage(with: id)
            }
    }
}

public extension View {
    func message(_ type: MessageType, text: String, duration: TimeInterval? = 3, key: String? = nil, isPresented: Binding<Bool>) -> some View {
        modifier(MessageModifier(
            isPresented: isPresented,
            type: type,
            text: text,
            duration: duration,
            key: key
        ))
    }
}
