//
//  Button+Shadow.swift
//  
//
//  Created by François Boulais on 01/07/2022.
//

import SwiftUI

internal extension Button {
    struct Shadow {
        let color: Color
        let offset: CGPoint
    }
    
    struct ShadowModifier: ViewModifier {
        let shadow: Shadow?
        
        func body(content: Content) -> some View {
            if let shadow = shadow {
                content
                    .shadow(color: shadow.color, radius: 0, x: shadow.offset.x, y: shadow.offset.y)
            } else {
                content
            }
        }
    }
}
