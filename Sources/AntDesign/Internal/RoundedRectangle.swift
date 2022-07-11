//
//  RoundedRectangle.swift
//  
//
//  Created by François Boulais on 11/07/2022.
//

import SwiftUI

struct RoundedRectangle: Shape {
    let corners: UIRectCorner
    let cornerRadius: CGFloat
    
    init(corners: UIRectCorner = .allCorners, cornerRadius: CGFloat) {
        self.corners = corners
        self.cornerRadius = cornerRadius
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        return Path(path.cgPath)
    }
}
