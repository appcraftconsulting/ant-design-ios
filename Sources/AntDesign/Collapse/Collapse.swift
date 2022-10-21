//
//  Collapse.swift
//  
//
//  Created by François Boulais on 20/10/2022.
//

import SwiftUI

@available(iOS 16.0, *)
public struct Collapse<Content: Sequence>: View where Content.Element: View {
    public enum ExpandIconPosition {
         case start, end
    }
    
    private let isBordered: Bool
    private let expandIconPosition: ExpandIconPosition
    private let expandIcon: Icon
    private let content: Content

    public init(
        isBordered: Bool = true,
        expandIconPosition: ExpandIconPosition = .start,
        expandIcon: Icon = .outlined(.right),
        @SequenceBuilder builder: () -> Content
    ) {
        self.isBordered = isBordered
        self.expandIconPosition = expandIconPosition
        self.expandIcon = expandIcon
        self.content = builder()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(sequence: content) { index, view in
                view
                if let array = Array(content), array.indices.last != index {
                    Preferences.borderColorBase
                        .frame(height: Preferences.borderWidthBase)
                }
            }
        }
        .background(Preferences.collapseContentBg)
        .disclosureGroupStyle(CollapseDisclosureGroupStyle(
            isBordered: isBordered,
            expandIconPosition: expandIconPosition,
            expandIcon: expandIcon
        ))
        .clipShape(RoundedRectangle(cornerRadius: Preferences.collapsePanelBorderRadius))
        .overlay {
            if isBordered {
                RoundedRectangle(cornerRadius: Preferences.collapsePanelBorderRadius)
                    .stroke(Preferences.borderColorBase, lineWidth: Preferences.borderWidthBase)
            }
        }
    }
    
    struct CollapseDisclosureGroupStyle: DisclosureGroupStyle {
        @Environment(\.isEnabled) internal var isEnabled: Bool

        private let transitionDuration: TimeInterval = 0.24
        
        internal let isBordered: Bool
        internal let expandIconPosition: ExpandIconPosition
        internal let expandIcon: Icon

        func makeBody(configuration: Configuration) -> some View {
            Group {
                Button {
                    withAnimation(.linear(duration: transitionDuration)) {
                        configuration.isExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: 0) {
                        if expandIconPosition == .start {
                            IconView(icon: expandIcon, fontSize: Preferences.fontSizeSm)
                                .rotationEffect(configuration.isExpanded ? .degrees(90) : .zero)
                                .padding(.trailing, Preferences.paddingSm)
                        }
                        
                        configuration.label
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Spacer(minLength: 0)
                        
                        if expandIconPosition == .end {
                            IconView(icon: expandIcon, fontSize: Preferences.fontSizeSm)
                                .rotationEffect(configuration.isExpanded ? .degrees(90) : .zero)
                                .padding(.leading, Preferences.paddingMd)
                        }
                    }
                    .padding(Preferences.collapseHeaderPadding)
                    .foregroundColor(isEnabled ? Preferences.textColor : Preferences.disabledColor)
                    .background(Preferences.collapseHeaderBg)
                }
                
                if configuration.isExpanded {
                    if isBordered {
                        Preferences.borderColorBase
                            .frame(height: Preferences.borderWidthBase)
                    }
                    
                    HStack(spacing: 0) {
                        if !isBordered && expandIconPosition == .start {
                            Spacer()
                                .frame(width: Preferences.fontSizeSm + Preferences.paddingSm)
                        }
                        
                        configuration.content
                            .transition(.opacity)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.init(
                        top: isBordered ? Preferences.collapseContentPadding : 4,
                        leading: Preferences.collapseContentPadding,
                        bottom: Preferences.collapseContentPadding,
                        trailing: Preferences.collapseContentPadding
                    ))
                    .foregroundColor(Preferences.textColor)
                    .background {
                        if !isBordered {
                            Preferences.collapseHeaderBg
                        }
                    }
                }
            }
            .font(.system(size: Preferences.fontSizeBase))
        }
    }
}
