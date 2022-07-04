//
//  Size.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import Foundation
import SwiftUI

public enum Size: String, CaseIterable {
    case small
    case middle
    case large

    public static let `default`: Self = .middle

    internal var icon: CGSize {
        switch self {
        case .small:
            return .init(width: 14, height: 14)
        case .middle:
            return .init(width: 16, height: 16)
        case .large:
            return .init(width: 18, height: 18)
        }
    }
    
    internal var font: CGFloat {
        switch self {
        case .small:
            return Preferences.fontSizeSm
        case .middle:
            return Preferences.fontSizeBase
        case .large:
            return Preferences.fontSizeLg
        }
    }
}
