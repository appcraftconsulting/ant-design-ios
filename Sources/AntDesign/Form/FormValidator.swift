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
    
    @Published public var input: T {
        didSet {
            if let newText = input as? String,
               let oldText = oldValue as? String,
               let len = rules.compactMap(\.len).first,
               newText.count > len,
               oldText.count <= len {
                input = oldValue
            }
        }
    }
    
    @Published public var isValid: Bool = false
    @Published internal var message: ValidateMessage?
        
    public init(initialValue: T, id: String = UUID().uuidString, rules: [Rule] = []) {
        self.id = id
        self.rules = rules
        self.input = initialValue
                
        $input
            .drop { $0 == initialValue }
            .map { value -> ValidateMessage? in
                for rule in rules {
                    if rule.required == true {
                        let defaultMessage = String(format: "%@ is required!")
                        if value == Optional.none {
                            return .init(text: rule.message ?? defaultMessage, status: .error)
                        } else if let string = value as? String, string.isEmpty {
                            return .init(text: rule.message ?? defaultMessage, status: .error)
                        }
                    }
                }
                
                return nil
            }
            .assign(to: &$message)
        
        $message
            .dropFirst()
            .map { $0?.status != .error }
            .assign(to: &$isValid)
        
        if rules.contains(where: { $0.required == true }) {
            isValid = false
        } else {
            isValid = true
        }
    }
}
