//
//  TableRow.swift
//  
//
//  Created by François Boulais on 07/09/2022.
//

import SwiftUI

public struct TableRow: View {
    public enum SelectionType {
        case checkbox, radio
    }
    
    public enum Size {
        case large, middle, small
    }
    
    @Binding var isSelected: Bool
    let selectionType: SelectionType
    let title: String
    let size: Size
    
    public init(size: Size, title: String, selectionType: SelectionType, isSelected: Binding<Bool>) {
        self.size = size
        self.title = title
        self.selectionType = selectionType
        self._isSelected = isSelected
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
        VStack {
            Button {
                isSelected.toggle()
            } label: {
                HStack(spacing: Preferences.tablePaddingHorizontal) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 14, height: 14)
                    
                    Text(title)
                        .font(.system(size: fontSize))
                        .foregroundColor(Preferences.textColor)
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
    let size: TableRow.Size
    
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
