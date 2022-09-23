//
//  ShadowModifier.swift
//  
//
//  Created by François Boulais on 04/07/2022.
//

import SwiftUI

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
