//
//  FormValidator.swift
//  
//
//  Created by François Boulais on 27/09/2022.
//

import Foundation

public class FormValidator<T: Equatable>: ObservableObject {
    public struct Rule {
        public enum `Type` {
            /// Must be of type string. This is the default type.
            case string
            /// Must be of type number.
            case number
            /// Must be of type boolean.
            case boolean
            /// Must be of type function.
            case method
            /// Must be an instance of RegExp or a string that does not generate an exception when creating a new RegExp.
            case regexp
            /// Must be of type number and an integer.
            case integer
            /// Must be of type number and a floating point number.
            case float
            /// Must be an array as determined by Array.isArray.
            case array
            /// Must be of type object and not Array.isArray.
            case object
            /// Value must exist in the enum.
            case `enum`
            /// Value must be valid as determined by Date
            case date
            /// Must be of type url.
            case url
            /// Must be of type hex.
            case hex
            /// Must be of type email.
            case email
            /// Can be any type.
            case `any`
        }
        
        let message: String?
        let type: `Type`
        let min: Int?
        let max: Int?
        let len: Int?
        let pattern: String?
        let required: Bool?
        let warningOnly: Bool
        let whitespace: Bool
        
        public init(
            message: String? = nil,
            type: `Type` = .string,
            min: Int? = nil,
            max: Int? = nil,
            len: Int? = nil,
            pattern: String? = nil,
            required: Bool? = nil,
            warningOnly: Bool = false,
            whitespace: Bool = false
        ) {
            self.message = message
            self.type = type
            self.min = min
            self.max = max
            self.len = len
            self.pattern = pattern
            self.required = required
            self.warningOnly = warningOnly
            self.whitespace = whitespace
        }
    }
    
    internal let id: String
    
    private let rules: [Rule]
    
    @Published public var input: T
    @Published public var isValid: Bool
    @Published internal var message: ValidateMessage?
        
    public init(initialValue: T, id: String = UUID().uuidString, label: String = "${label}", rules: [Rule] = []) {
        self.id = id
        self.rules = rules
        self.input = initialValue
                
        if rules.contains(where: { $0.required == true }) {
            isValid = false
        } else {
            isValid = true
        }
        
        $input
            .drop { $0 == initialValue }
            .map { value -> ValidateMessage? in
                var defaultMessage: String?
                
                for rule in rules {
                    if let required = rule.required, required {
                        if value == Optional.none {
                            defaultMessage = String(format: "form_defaultValidateMessages_required", label)
                        } else if let string = value as? String, string.isEmpty {
                            defaultMessage = String(format: "form_defaultValidateMessages_required", label)
                        }
                    } else if let min = rule.min, let max = rule.max, let string = value as? String {
                        if string.count < min && string.count > max {
                            defaultMessage = String(format: "form_defaultValidateMessages_string_range", label, min, max)
                        }
                    } else if let min = rule.min, let string = value as? String {
                        if string.count < min {
                            defaultMessage = String(format: "form_defaultValidateMessages_string_min", label, min)
                        }
                    }else if let max = rule.max, let string = value as? String {
                        if string.count > max {
                            defaultMessage = String(format: "form_defaultValidateMessages_string_max", label, max)
                        }
                    } else if let len = rule.len, let string = value as? String {
                        if string.count != len {
                            defaultMessage = String(format: "form_defaultValidateMessages_string_len", label, len)
                        }
                    } else if let pattern = rule.pattern, let string = value as? String {
                        if string.range(of: pattern, options: .regularExpression) == nil {
                            defaultMessage = String(format: "form_defaultValidateMessages_pattern_mismatch", label, pattern)
                        }
                    }
                    
                    if let defaultMessage {
                        return .init(
                            text: rule.message ?? defaultMessage,
                            status: rule.warningOnly ? .warning : .error
                        )
                    }
                }
                
                return nil
            }
            .assign(to: &$message)
        
        $message
            .dropFirst()
            .map { $0?.status != .error }
            .assign(to: &$isValid)
    }
}
