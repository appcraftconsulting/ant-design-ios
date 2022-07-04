//
//  BorderSize.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import SwiftUI

public enum BorderStyle {
    case solid, dashed
    
    internal var dash: [CGFloat] {
        switch self {
        case .solid:
            return []
        case .dashed:
            return [4]
        }
    }
}
