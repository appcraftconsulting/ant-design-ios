//
//  MessageManager.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import Combine
import Foundation
import UIKit

internal final class MessageManager: ObservableObject {
    @Published internal var messages = [Message]()
    
    private var timers = Dictionary<String, Timer>()
    private let generator = UINotificationFeedbackGenerator()
    
    init() {
        generator.prepare()
    }
    
    internal func presentMessage(with id: String, type: MessageType, text: String, duration: TimeInterval?, key: String) {
        if let index = messages.firstIndex(where: { $0.key == key }) {
            timers[key]?.invalidate()
            messages[index].id = id
            messages[index].type = type
            messages[index].text = text
        } else {
            messages.append(.init(id: id, type: type, text: text, key: key))
        }
        
        if let duration = duration {
            let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                self?.messages.removeAll(where: { $0.key == key })
                self?.timers.removeValue(forKey: key)
            }
            
            timers[key] = timer
        }
        
        switch type {
        case .success:
            generator.notificationOccurred(.success)
        case .error:
            generator.notificationOccurred(.error)
        case .warning:
            generator.notificationOccurred(.warning)
        case .info, .loading:
            break
        }
    }
    
    internal func destroyMessage(with id: String) {
        for message in messages where message.id == id {
            timers[message.key]?.invalidate()
        }
        
        messages.removeAll(where: { $0.id == id })
    }
    
    internal func hasMessage(with id: String) -> AnyPublisher<Bool, Never> {
        $messages
            .map { message in
                message.contains(where: { $0.id == id })
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
