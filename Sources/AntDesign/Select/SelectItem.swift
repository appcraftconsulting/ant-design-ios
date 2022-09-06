//
//  SelectItem.swift
//  
//
//  Created by François Boulais on 31/08/2022.
//

import SwiftUI

public struct SelectItem: View {
    private let title: String

    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding private var isSelected: Bool
    
    public init(title: String, isSelected: Binding<Bool>) {
        self.title = title
        self._isSelected = isSelected
    }
    
    public var body: some View {
        Button(title) {
            isSelected.toggle()
        }
        .buttonStyle(SelectItemButtonStyle(isSelected: isSelected, isEnabled: isEnabled))
    }
}

fileprivate struct SelectItemButtonStyle: SwiftUI.ButtonStyle {
    internal let isSelected: Bool
    internal let isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {

        HStack(alignment: .center) {
            configuration.label
                .foregroundColor(isEnabled ? Preferences.textColor : Preferences.disabledColor)
                .font(.system(size: Preferences.selectDropdownFontSize, weight: isSelected ? .bold : .regular))
                .lineLimit(1)
            
            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Preferences.primaryColor)
                    .font(.system(size: Preferences.selectDropdownFontSize))
            }
        }
        .animation(nil, value: isSelected)
        .frame(maxWidth: .infinity)
        .frame(height: Preferences.selectDropdownHeight)
        .padding(.horizontal)
        .background {
            if isSelected {
                Preferences.selectItemSelectedBg
            } else if configuration.isPressed {
                Preferences.selectItemActiveBg
            } else {
                Preferences.selectClearBackground
            }
        }
    }
}
