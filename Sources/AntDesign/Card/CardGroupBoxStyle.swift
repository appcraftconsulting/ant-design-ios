//
//  CardGroupBoxStyle.swift
//  
//
//  Created by François Boulais on 22/08/2022.
//

import SwiftUI

public struct CardGroupBoxStyle: GroupBoxStyle {
    public enum Size {
        case `default`
        case small
    }
    
    private let size: Size
    private let isInner: Bool
    private let isBordered: Bool
    
    private var cardHeadFontSize: CGFloat {
        switch size {
        case .default:
            return Preferences.cardHeadFontSize
        case .small:
            return Preferences.cardHeadFontSizeSm
        }
    }
    
    private var cardHeadPadding: CGFloat {
        switch size {
        case .default:
            return Preferences.cardHeadPadding
        case .small:
            return Preferences.cardHeadPaddingSm
        }
    }
    
    private var cardPaddingBase: CGFloat {
        switch size {
        case .default:
            return Preferences.cardPaddingBase
        case .small:
            return Preferences.cardPaddingBaseSm
        }
    }
    
    private var cardHeadHeight: CGFloat {
        switch size {
        case .default:
            return Preferences.cardHeadHeight
        case .small:
            return Preferences.cardHeadHeightSm
        }
    }
    
    public init(size: Size = .default, isInner: Bool = false, isBordered: Bool = true) {
        self.size = size
        self.isInner = isInner
        self.isBordered = isBordered
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            HStack {
                configuration.label
                    .font(.system(size: cardHeadFontSize, weight: .semibold))
                    .padding(.vertical, cardHeadPadding)
                    .padding(.horizontal, cardPaddingBase)
                    .frame(height: cardHeadHeight)
                    .foregroundColor(Preferences.cardHeadColor)
                
                Spacer()
            }
            .background(isInner ? Preferences.backgroundColorBase : Preferences.cardHeadBackground)

            Rectangle()
                .fill(Preferences.borderColorSplit)
                .frame(height: Preferences.borderWidthBase)
            
            HStack(spacing: 0) {
                configuration.content
                    .padding(cardPaddingBase)
                    .font(.system(size: Preferences.fontSizeBase))
                    .foregroundColor(Preferences.textColor)
                
                Spacer(minLength: 0)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: Preferences.cardRadius)
                .fill(Preferences.cardBackground)
        }
        .overlay {
            if isBordered {
                RoundedRectangle(cornerRadius: Preferences.cardRadius)
                    .stroke(Preferences.borderColorSplit, lineWidth: Preferences.borderWidthBase)
            }
        }
    }
}
