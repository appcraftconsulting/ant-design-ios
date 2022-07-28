//
//  ProgressSuccess.swift
//  
//
//  Created by François Boulais on 18/07/2022.
//

import SwiftUI

public struct ProgressSuccess {
    let percent: CGFloat
    let color: Color
    
    public init(percent: CGFloat, color: Color = Preferences.successColor) {
        self.percent = percent
        self.color = color
    }
}
