//
//  ValidationType.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-03.
//

import Foundation

enum ValidationType {
    case isEmpty
    case isNotEmpty
    case email
}

extension ValidationType {

    func isValid(_ text: String) ->ValidationResult {
        switch self {
        case .isEmpty:
            return text.isEmpty
        case .isNotEmpty:
            return text.isNotEmpty
        case .email:
            return text.isEmail
        }
    }
}

enum RegEx {
    case email
}

extension RegEx {
    var expression: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
    }
}

enum ValidationError: Error {
    case invalidUserName
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case invalidPhone
}

extension ValidationError: LocalizedError {
    internal var errorDescription: String? {
        switch self {
        case .invalidUserName:
            return NSLocalizedString("Username allows only small a to z, capital A to Z, 0 to 9 number with _ underscore and without spaces.", comment: "")
        case .invalidFirstName:
            return NSLocalizedString("Firstname allows only small a to z, capital A to Z, 0 to 9 number with _ underscore and without spaces.", comment: "")
        case .invalidLastName:
            return NSLocalizedString("Lastname allows only small a to z, capital A to Z, 0 to 9 number with _ underscore and without spaces.", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid e-mail format.", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Password must contain: 1 capital letter, 1 small letter, number and 1 special character", comment: "")
        case .invalidPhone:
            return NSLocalizedString("Invalid Phone format", comment: "")
        }
    }
}
