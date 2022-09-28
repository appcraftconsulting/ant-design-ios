//
//  EnvironmentValues+AntDesign.swift
//  
//
//  Created by François Boulais on 11/07/2022.
//

import SwiftUI

internal struct InputGroupManagerKey: EnvironmentKey {
    static let defaultValue: InputGroupManager? = nil
}

internal struct InputStatusKey: EnvironmentKey {
    static let defaultValue: InputStatus? = nil
}


public extension EnvironmentValues {
    var inputGroupManager: InputGroupManager? {
        get { self[InputGroupManagerKey.self] }
        set { self[InputGroupManagerKey.self] = newValue }
    }
    
    var inputStatus: InputStatus? {
        get { self[InputStatusKey.self] }
        set { self[InputStatusKey.self] = newValue }
    }
}

