//
//  TableRow.swift
//  
//
//  Created by François Boulais on 07/09/2022.
//

import SwiftUI

public enum TableRowSize {
    case large, middle, small
}

public struct TableRow<Label>: View where Label : View {
    @Environment(\.isEnabled) private var isEnabled: Bool

    public enum SelectionType {
        case checkbox, radio
    }
    
    private struct SelectionTypeViewModifier: ViewModifier {
        let selectionType: SelectionType
        
        func body(content: Content) -> some View {
            switch selectionType {
            case .radio:
                content.toggleStyle(RadioToggleStyle())
            case .checkbox:
                content.toggleStyle(CheckboxToggleStyle())
            }
        }
    }

    
    @Binding var isSelected: Bool
    let selectionType: SelectionType?
    let label: Label
    let size: TableRowSize
    
    public init(
        size: TableRowSize,
        selectionType: SelectionType? = nil,
        isSelected: Binding<Bool>? = nil,
        label: () -> Label
    ) {
        self.size = size
        self.label = label()
        self.selectionType = selectionType
        self._isSelected = isSelected ?? .constant(false)
    }
    
    private var fontSize: CGFloat {
        switch size {
        case .small:
            return Preferences.tableFontSizeSm
        case .middle:
            return Preferences.tableFontSizeMd
        case .large:
            return Preferences.tableFontSize
        }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                isSelected.toggle()
            } label: {
                if let selectionType = selectionType {
                    Toggle(isOn: $isSelected) {
                        label
                    }
                    .modifier(SelectionTypeViewModifier(selectionType: selectionType))
                    .labelsHidden()
                } else {
                    HStack {
                        label
                        Spacer()
                    }
                }
            }

            Preferences.tableBorderColor
                .frame(height: Preferences.borderWidthBase)
        }
        .buttonStyle(TableRowButtonStyle(isSelected: isSelected, size: size))
        .frame(maxWidth: .infinity)
    }
}

fileprivate struct TableRowButtonStyle: SwiftUI.ButtonStyle {
    let isSelected: Bool
    let size: TableRowSize
    
    private var horizontalPadding: CGFloat {
        switch size {
        case .small:
            return Preferences.tablePaddingHorizontalSm
        case .middle:
            return Preferences.tablePaddingHorizontalMd
        case .large:
            return Preferences.tablePaddingHorizontal
        }
    }
    
    private var verticalPadding: CGFloat {
        switch size {
        case .small:
            return Preferences.tablePaddingVerticalSm
        case .middle:
            return Preferences.tablePaddingVerticalMd
        case .large:
            return Preferences.tablePaddingVertical
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background {
                if isSelected {
                    Preferences.tableSelectedRowBg
                } else if configuration.isPressed {
                    Preferences.tableRowHoverBg
                } else {
                    Preferences.tableBg
                }
            }
    }
}
