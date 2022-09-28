//
//  FormItem.swift
//  
//
//  Created by François Boulais on 21/09/2022.
//

import Combine
import SwiftUI

internal class FormItemViewModel: ObservableObject {
    @Published internal var message: ValidateMessage?
}

public struct FormItem<Content : View>: View {
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
    
    @Environment(\.inputGroupManager) private var inputGroupManager: InputGroupManager?
    @ObservedObject private var viewModel = FormItemViewModel()
    
    private let label: Label?
    private let content: Content
    private var cancellables = Set<AnyCancellable>()
    private var validatorId: String?
    
    private var bottomPadding: CGFloat {
        if inputGroupManager == nil {
            return Preferences.formItemMarginBottom
        } else {
            return 0
        }
    }

    public init<T>(
        label: Label? = nil,
        validator: FormValidator<T>? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.content = content()
        
        validator?.$message
            .assign(to: \.message, on: viewModel)
            .store(in: &cancellables)
        
        validatorId = validator?.id
    }
    
    public init(
        label: Label? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.content = content()
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

            content
                .frame(minHeight: Preferences.inputHeightBase)
            
            if let message = viewModel.message, inputGroupManager == nil {
                Text(message.text)
                    .modifier(ExplainModifier(status: message.status))
            }
        }
        .padding(.bottom, bottomPadding)
        .environment(\.inputStatus, viewModel.message?.status)
        .onReceive(viewModel.$message) { message in
            if let id = validatorId {
                inputGroupManager?.messages[id] = message
            }
        }
        .onDisappear {
            if let id = validatorId {
                inputGroupManager?.messages.removeValue(forKey: id)
            }
        }
    }
}

internal struct ValidateMessage: Equatable {
    let date: Date
    let text: String
    let status: InputStatus
    
    init(text: String, status: InputStatus) {
        self.date = .now
        self.text = text
        self.status = status
    }
}

public enum InputStatus {
    case error
    case warning
    
    var color: Color {
        switch self {
        case .error:
            return Preferences.errorColor
        case .warning:
            return Preferences.warningColor
        }
    }
}
