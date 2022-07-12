//
//  GroupPosition.swift
//  
//
//  Created by François Boulais on 11/07/2022.
//

import SwiftUI

public enum GroupPosition {
    case first
    case middle
    case last
    case alone
}

internal struct GroupPositionKey: EnvironmentKey {
    static let defaultValue: GroupPosition = .alone
}

public extension EnvironmentValues {
    var groupPosition: GroupPosition {
        get { self[GroupPositionKey.self] }
        set { self[GroupPositionKey.self] = newValue }
    }
}
