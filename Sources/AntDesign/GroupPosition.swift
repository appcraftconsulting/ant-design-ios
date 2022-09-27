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

public class InputGroupManager: ObservableObject {
    @Published internal var message: ValidateMessage?
}

internal struct GroupPositionKey: EnvironmentKey {
    static let defaultValue: GroupPosition = .alone
}

internal struct InputGroupManagerKey: EnvironmentKey {
    static let defaultValue: InputGroupManager? = nil
}

internal struct InputStatusKey: EnvironmentKey {
    static let defaultValue: InputStatus? = nil
}


public extension EnvironmentValues {
    var groupPosition: GroupPosition {
        get { self[GroupPositionKey.self] }
        set { self[GroupPositionKey.self] = newValue }
    }
    
    var inputGroupManager: InputGroupManager? {
        get { self[InputGroupManagerKey.self] }
        set { self[InputGroupManagerKey.self] = newValue }
    }
    
    var inputStatus: InputStatus? {
        get { self[InputStatusKey.self] }
        set { self[InputStatusKey.self] = newValue }
    }
}

