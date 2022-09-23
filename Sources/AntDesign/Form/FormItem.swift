//
//  FormItem.swift
//  
//
//  Created by François Boulais on 21/09/2022.
//

import SwiftUI

public struct FormItem<InputGroup>: View where InputGroup : View {
    public enum RequiredMark {
        case optional
        case required
    }
    
    let label: String
    let requiredMark: RequiredMark?
    let inputGroup: InputGroup
    
    public init(label: String, requiredMark: RequiredMark? = nil, inputGroup: () -> InputGroup) {
        self.label = label
        self.requiredMark = requiredMark
        self.inputGroup = inputGroup()
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Group {
                if requiredMark == .required {
                    Text("* ")
                        .foregroundColor(Preferences.labelRequiredColor)
                        .font(.system(size: Preferences.formItemLabelFontSize)) +
                    Text(label)
                        .foregroundColor(Preferences.labelColor)
                        .font(.system(size: Preferences.formItemLabelFontSize))
                } else if requiredMark == .optional {
                    Text(label)
                        .foregroundColor(Preferences.labelColor)
                        .font(.system(size: Preferences.formItemLabelFontSize)) +
                    Text(" ") +
                    Text("form_optional", bundle: .module)
                        .foregroundColor(Preferences.textColorSecondary)
                        .font(.system(size: Preferences.formItemLabelFontSize))
                } else {
                    Text(label)
                        .foregroundColor(Preferences.labelColor)
                        .font(.system(size: Preferences.formItemLabelFontSize))
                }
            }

            inputGroup
        }
    }
}
