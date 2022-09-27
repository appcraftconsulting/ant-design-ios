//
//  ExplainModifier.swift
//  
//
//  Created by François Boulais on 27/09/2022.
//

import SwiftUI

internal struct ExplainModifier: ViewModifier {
    let status: InputStatus?
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: Preferences.fontSizeBase))
            .foregroundColor(status?.color ?? Preferences.textColorSecondary)
    }
}
