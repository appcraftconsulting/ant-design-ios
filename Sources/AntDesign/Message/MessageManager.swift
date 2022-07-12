//
//  MessageManager.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import Foundation

internal final class MessageManager: ObservableObject {
    @Published var messages = [Message]()
    
    private var timers = Dictionary<String, Timer>()
    
    internal func presentMessage(with type: MessageType, text: String, duration: TimeInterval, key: String) {
        if let timer = timers[key], let index = messages.firstIndex(where: { $0.key == key }) {
            timer.invalidate()
            messages[index].type = type
            messages[index].text = text
        } else {
            messages.append(.init(type: type, text: text, key: key))
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.messages.removeAll(where: { $0.key == key })
            self?.timers.removeValue(forKey: key)
        }
        
        timers[key] = timer
    }
}
