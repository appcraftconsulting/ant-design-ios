//
//  Message.swift
//  
//
//  Created by François Boulais on 12/07/2022.
//

import Foundation

internal struct Message: Equatable {
    var id: String
    var type: MessageType
    var text: String
    let key: String
}
