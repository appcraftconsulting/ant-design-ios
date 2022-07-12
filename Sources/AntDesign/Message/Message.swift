//
//  Message.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import Foundation

internal struct Message: Identifiable, Equatable {
    var type: MessageType
    var text: String
    let key: String

    // MARK: - Identifiable
    
    var id: String {
        key
    }
}
