//
//  SelectItemButtonStyle.swift
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
        Button {
            isSelected.toggle()
        } label: {
            HStack(alignment: .center) {
                Text(title)
                    .foregroundColor(isEnabled ? Preferences.textColor : Preferences.disabledColor)
                    .fontWeight(isSelected ? .bold : .regular)
                    .lineLimit(1)
                
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Preferences.primaryColor)
                }
            }
        }
        .font(.system(size: Preferences.selectDropdownFontSize))
        .listRowBackground(isSelected ? Preferences.selectItemSelectedBg : Preferences.selectClearBackground)
        .listRowSeparator(.hidden)
    }
}
