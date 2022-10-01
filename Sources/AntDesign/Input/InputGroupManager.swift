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

    var mostRecentMessage: ValidateMessage? {
        messages
            .values
            .compactMap { $0 }
            .sorted(by: { $0.date > $1.date })
            .first
    }
}
