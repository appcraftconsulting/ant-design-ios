//
//  Alert.swift
//  
//
//  Created by François Boulais on 19/08/2022.
//

import SwiftUI

/// Alert component for feedback.
///
/// When To Use
/// - When you need to show alert messages to users.
/// - When you need a persistent static container which is closable by user actions.
public struct Alert: View {
    public enum `Type` {
        case success, info, warning, error
        
        internal func icon(hasDescription: Bool) -> Icon {
            switch (self, hasDescription) {
            case (.success, false):
                return .filled(.checkCircle)
            case (.success, true):
                return .outlined(.checkCircle)
            case (.info, false):
                return .filled(.infoCircle)
            case (.info, true):
                return .outlined(.infoCircle)
            case (.warning, false):
                return .filled(.exclamationCircle)
            case (.warning, true):
                return .outlined(.exclamationCircle)
            case (.error, false):
                return .filled(.closeCircle)
            case (.error, true):
                return .outlined(.closeCircle)
            }
        }
        
        internal var iconColor: Color {
            switch self {
            case .success:
                return Preferences.alertSuccessIconColor
            case .info:
                return Preferences.alertInfoIconColor
            case .warning:
                return Preferences.alertWarningIconColor
            case .error:
                return Preferences.alertErrorIconColor
            }
        }
        
        internal var bgColor: Color {
            switch self {
            case .success:
                return Preferences.alertSuccessBgColor
            case .info:
                return Preferences.alertInfoBgColor
            case .warning:
                return Preferences.alertWarningBgColor
            case .error:
                return Preferences.alertErrorBgColor
            }
        }
        
        internal var borderColor: Color {
            switch self {
            case .success:
                return Preferences.alertSuccessBorderColor
            case .info:
                return Preferences.alertInfoBorderColor
            case .warning:
                return Preferences.alertWarningBorderColor
            case .error:
                return Preferences.alertErrorBorderColor
            }
        }
    }
    
    @State private var isClosed = false
    
    internal let type: `Type`
    internal let isBanner: Bool
    internal let isClosable: Bool
    internal let closeIcon: Icon
    internal let description: String?
    internal let icon: Icon?
    internal let message: String?
    internal let showIcon: Bool
    internal let onClose: (() -> Void)?
    internal let closeText: String?
    
    internal let isError: Bool
    
    private var hasDescription: Bool {
        description != nil
    }
    
    private var descriptionFont: Font {
        if isError {
            return .system(size: Preferences.fontSizeBase, weight: .medium).monospaced()
        } else {
            return .system(size: Preferences.fontSizeBase)
        }
    }
    
    private var padding: EdgeInsets {
        if hasDescription && !showIcon {
            return .init(
                top: Preferences.alertWithDescriptionNoIconPaddingVertical,
                leading: 15,
                bottom: Preferences.alertWithDescriptionNoIconPaddingVertical,
                trailing: 15
            )
        } else if hasDescription && showIcon {
            return Preferences.alertWithDescriptionPadding
        } else {
            return .init(top: 8, leading: 15, bottom: 8, trailing: 15)
        }
    }
    
    public var body: some View {
        Group {
            if !isClosed {
                HStack(alignment: hasDescription ? .top : .center) {
                    if hasDescription {
                        Label {
                            VStack(alignment: .leading, spacing: 8) {
                                if let message = message {
                                    Text(message)
                                        .font(.system(size: Preferences.fontSizeLg, weight: .medium))
                                        .foregroundColor(Preferences.alertMessageColor)
                                        .lineSpacing(4)
                                }
                                
                                if let description = description {
                                    Text(description)
                                        .font(descriptionFont)
                                        .foregroundColor(Preferences.alertTextColor)
                                        .lineSpacing(4)
                                }
                            }
                        } icon: {
                            if showIcon {
                                IconView(icon: icon ?? type.icon(hasDescription: true), fontSize: Preferences.alertWithDescriptionIconSize)
                                    .foregroundColor(type.iconColor)
                            }
                        }
                    } else {
                        HStack(alignment: .center) {
                            if showIcon {
                                IconView(icon: icon ?? type.icon(hasDescription: false), fontSize: Preferences.fontSizeLg)
                                    .foregroundColor(type.iconColor)
                            }
                            
                            if let message = message {
                                Text(message)
                                    .font(.system(size: Preferences.fontSizeBase))
                                    .foregroundColor(Preferences.alertMessageColor)
                                    .lineSpacing(4)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if isClosable {
                        Button(action: close) {
                            Group {
                                if let closeText = closeText {
                                    Text(closeText)
                                        .font(.system(size: Preferences.fontSizeSm))
                                } else {
                                    IconView(
                                        icon: closeIcon,
                                        fontSize: Preferences.fontSizeSm
                                    )
                                }
                            }
                            .foregroundColor(Preferences.alertCloseColor)
                        }
                    }
                }
                .padding(padding)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: isBanner ? 0 : Preferences.borderRadiusBase)
                        .fill(type.bgColor)
                }
                .overlay {
                    if !isBanner {
                        RoundedRectangle(cornerRadius: Preferences.borderRadiusBase)
                            .stroke(type.borderColor, lineWidth: Preferences.borderWidthBase)
                    }
                }
            }
        }
        .transition(.scale)
    }
    
    // MARK: - Private functions
    
    private func close() {
        withAnimation {
            isClosed = true
        }
    }
}

public extension Alert {
    /// Alert component for feedback.
    /// - Parameters:
    ///   - type: Type of Alert styles, options: `success`, `info`, `warning`, `error`
    ///   - message: Content of Alert
    ///   - description: Additional content of Alert
    ///   - icon: Custom icon, effective when `showIcon` is true
    ///   - showIcon: Whether to show icon
    ///   - isBanner: Whether to show as banner
    ///   - isClosable: Whether Alert can be closed
    ///   - closeIcon: Custom close icon
    ///   - closeText: Close text to show
    ///   - onClose: Callback when Alert is closed
    init(
        type: `Type`? = nil,
        message: String? = nil,
        description: String? = nil,
        icon: Icon? = nil,
        showIcon: Bool? = nil,
        isBanner: Bool = false,
        isClosable: Bool = false,
        closeIcon: Icon = .outlined(.close),
        closeText: String? = nil,
        onClose: (() -> Void)? = nil
    ) {
        self.type = type ?? (isBanner ? .warning : .info)
        self.message = message
        self.description = description
        self.icon = icon
        self.showIcon = showIcon ?? isBanner ? true : false
        self.isBanner = isBanner
        self.isClosable = closeText != nil ? true : isClosable
        self.closeIcon = closeIcon
        self.closeText = closeText
        self.onClose = onClose
        self.isError = false
    }
    
    /// ErrorBoundary Component for making error handling easier in Swift
    /// - Parameter error: Custom error to show
    init(error: Error) {
        let nsError = error as NSError
        let message = "Error: \(nsError.code)"
        let description = nsError.debugDescription
        
        self.init(
            type: .error,
            isBanner: false,
            isClosable: false,
            closeIcon: .outlined(.close),
            description: description,
            icon: nil,
            message: message,
            showIcon: false,
            onClose: nil,
            closeText: nil,
            isError: true
        )
    }
}
