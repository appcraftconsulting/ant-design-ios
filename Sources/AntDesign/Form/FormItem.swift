//
//  FormItem.swift
//  
//
//  Created by François Boulais on 21/09/2022.
//

import SwiftUI

public struct FormItem<InputGroup>: View where InputGroup : View {
    public struct Label {
        public enum RequiredMark {
            case optional
            case required
        }
        
        let text: String
        let requiredMark: RequiredMark?
        
        public init(text: String, requiredMark: RequiredMark?) {
            self.text = text
            self.requiredMark = requiredMark
        }
    }
    
    let label: Label?
    let inputGroup: InputGroup

    public init(label: Label? = nil, @ViewBuilder inputGroup: () -> InputGroup) {
        self.label = label
        self.inputGroup = inputGroup()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let label = label {
                Group {
                    if label.requiredMark == .required {
                        Text("* ")
                            .foregroundColor(Preferences.labelRequiredColor)
                            .font(.system(size: Preferences.formItemLabelFontSize)) +
                        Text(label.text)
                            .foregroundColor(Preferences.labelColor)
                            .font(.system(size: Preferences.formItemLabelFontSize))
                    } else if label.requiredMark == .optional {
                        Text(label.text)
                            .foregroundColor(Preferences.labelColor)
                            .font(.system(size: Preferences.formItemLabelFontSize)) +
                        Text(" ") +
                        Text("form_optional", bundle: .module)
                            .foregroundColor(Preferences.textColorSecondary)
                            .font(.system(size: Preferences.formItemLabelFontSize))
                    } else {
                        Text(label.text)
                            .foregroundColor(Preferences.labelColor)
                            .font(.system(size: Preferences.formItemLabelFontSize))
                    }
                }
                .padding(.bottom, 8)
            }

            inputGroup
        }
        .padding(.bottom, Preferences.formItemMarginBottom)
    }
}
