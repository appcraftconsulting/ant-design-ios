//
//  Empty.swift
//  
//
//  Created by François Boulais on 08/09/2022.
//

import SwiftUI

public struct Empty: View {
    private let image: Image
    private let description: String?
    
    public init(image: Image = .EMPTY_PRESENTED_IMAGE_DEFAULT, description: String? = nil) {
        self.image = image
        self.description = description
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            image
                .foregroundColor(Preferences.textColor)
            
            if let description = description {
                Text(description)
                    .font(.system(size: Preferences.emptyFontSize))
            }
        }
        .modifier(NormalModifier(isNormal: image == .EMPTY_PRESENTED_IMAGE_SIMPLE))
    }
    
    private struct NormalModifier: ViewModifier {
        let isNormal: Bool
        
        func body(content: Content) -> some View {
            if isNormal {
                content
                    .padding(.vertical, 32)
                    .foregroundColor(Preferences.disabledColor)
            } else {
                content
            }
        }
    }
}

public extension Image {
    static var EMPTY_PRESENTED_IMAGE_SIMPLE: Self {
        .init("Empty/PRESENTED_IMAGE_SIMPLE", bundle: .module)
    }
    
    static var EMPTY_PRESENTED_IMAGE_DEFAULT: Self {
        .init("Empty/PRESENTED_IMAGE_DEFAULT", bundle: .module)
    }
}
