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

public struct TableRow<Label, ExpandedLabel>: View where Label : View, ExpandedLabel: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var isExpanded: Bool = false

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
    let expandedRow: ExpandedLabel?
    let size: TableRowSize
    
    public init(
        size: TableRowSize,
        selectionType: SelectionType? = nil,
        isSelected: Binding<Bool>? = nil,
        label: () -> Label,
        expandedRow: (() -> ExpandedLabel)? = nil
    ) {
        self.size = size
        self.label = label()
        self.selectionType = selectionType
        self._isSelected = isSelected ?? .constant(false)
        self.expandedRow = expandedRow?()
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
    
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                isSelected.toggle()
            } label: {
                HStack(spacing: Preferences.paddingMd) {
                    if expandedRow != nil {
                        TableRowExpandButton(isExpanded: $isExpanded)
                    }
                    
                    if let selectionType = selectionType {
                        Toggle(isOn: $isSelected) {
                            label
                        }
                        .modifier(SelectionTypeViewModifier(selectionType: selectionType))
                        .labelsHidden()
                    } else {
                        label
                    }
                    
                    Spacer()
                }
            }

            Preferences.tableBorderColor
                .frame(height: Preferences.borderWidthBase)
            
            Group {
                if isExpanded, let expandedRow = expandedRow {
                    HStack {
                        expandedRow
                        Spacer()
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
                    .background(Preferences.tableExpandedRowBg)
                    .foregroundColor(Preferences.textColor)
                    
                    Preferences.tableBorderColor
                        .frame(height: Preferences.borderWidthBase)
                }
            }
        }
        .font(.system(size: fontSize))
        .buttonStyle(TableRowButtonStyle(
            isSelected: isSelected,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding
        ))
        .animation(.default, value: isExpanded)
        .frame(maxWidth: .infinity)
    }
}

extension TableRow where ExpandedLabel == EmptyView {
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
        self.expandedRow = nil
    }
}

fileprivate struct TableRowExpandButton: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button(isExpanded ? "Collapse" : "Expand") {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .buttonStyle(ButtonStyle(isExpanded: isExpanded))
    }
    
    struct ButtonStyle: SwiftUI.ButtonStyle {
        let isExpanded: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            let expandIconSize = ceil(((Preferences.fontSizeSm * 1.4 - Preferences.borderWidthBase * 3) / 2)) * 2 +
            Preferences.borderWidthBase * 3
            
            RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                .fill(Preferences.tableExpandIconBg)
                .frame(width: expandIconSize, height: expandIconSize)
                .overlay {
                    RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                        .stroke(
                            configuration.isPressed ? Preferences.primaryColor : Preferences.tableBorderColor,
                            lineWidth: Preferences.borderWidthBase
                        )
                }
                .overlay {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(configuration.isPressed ? Preferences.primaryColor : Preferences.textColor)
                            .frame(width: Preferences.borderWidthBase)
                            .rotationEffect(isExpanded ? .degrees(90) : .degrees(0))
                        
                        Rectangle()
                            .fill(configuration.isPressed ? Preferences.primaryColor : Preferences.textColor)
                            .frame(height: Preferences.borderWidthBase)
                            .rotationEffect(isExpanded ? .degrees(180) : .degrees(0))
                    }
                    .padding(3 + Preferences.borderWidthBase)
                }
                .scaleEffect(Preferences.checkboxSize / expandIconSize)
        }
    }
}

fileprivate struct TableRowButtonStyle: SwiftUI.ButtonStyle {
    let isSelected: Bool
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    
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
