//
//  ButtonLayout.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import Foundation

public enum ButtonLayout: String, CaseIterable {
    case iconOnly
    case titleOnly
    case titleAndIcon
    
    public static var `default`: Self = .titleAndIcon
    
    internal var hasIcon: Bool {
        self == .titleAndIcon || self == .iconOnly
    }
    
    internal var hasTitle: Bool {
        self == .titleAndIcon || self == .titleOnly
    }
}
