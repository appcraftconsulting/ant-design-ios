//
//  InputGroupManager.swift
//  
//
//  Created by François Boulais on 28/09/2022.
//

import Combine
import Foundation

public class InputGroupManager: ObservableObject {
    @Published internal var messages = [String : ValidateMessage?]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $messages
            .print("InputGroupManager | messages")
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    var mostRecentMessage: ValidateMessage? {
        messages
            .values
            .compactMap { $0 }
            .sorted(by: { $0.date > $1.date })
            .first
    }
}
