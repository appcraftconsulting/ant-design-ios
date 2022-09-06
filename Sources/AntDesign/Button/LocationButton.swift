//
//  LocationButton.swift
//  
//
//  Created by François Boulais on 24/08/2022.
//

import CoreLocationUI
import SwiftUI

public struct LocationButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.componentSize) internal var size: ComponentSize

    private let title: CoreLocationUI.LocationButton.Title?
    private let action: () -> Void
    
    private var cornerRadius: CGFloat {
        switch size {
        case .middle, .large:
            return Preferences.btnBorderRadiusBase
        case .small:
            return Preferences.btnBorderRadiusSm
        }
    }
    
    public init(_ title: CoreLocationUI.LocationButton.Title? = nil, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        CoreLocationUI.LocationButton(title, action: action)
            .tint(isEnabled ? Preferences.btnPrimaryBg : Preferences.btnDisableBg)
            .foregroundColor(isEnabled ? Preferences.btnPrimaryColor : Preferences.btnDisableColor)
            .font(.system(size: size.font, weight: Preferences.btnFontWeight))
            .cornerRadius(cornerRadius)
            .padding(Preferences.btnBorderWidth / 2)
    }
}
