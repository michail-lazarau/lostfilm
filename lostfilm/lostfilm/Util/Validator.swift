//
//  Validator.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-03.
//

import Foundation

enum ValidationError: Error {
    case invalidUserName
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
}

class Validator {
    private let minLength = 6
    private lazy var comonRegex = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){\(minLength)}"
    private lazy var userNamesRegex = "^[a-zA-Z0-9_]{1,13}$"
    private lazy var emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    func validateUsername(username: String) throws {
        if username.matches(userNamesRegex) {
            print("Username matches with requirements")
        } else if username.count < minLength {throw ValidationError.invalidUserName} else {
            throw  ValidationError.invalidUserName
        }
    }

    func validateFirstName(firstname: String) throws {
        if firstname.matches(userNamesRegex) {
            print("Firstname matches with requirements")
        } else if firstname.count < minLength {
            throw ValidationError.invalidFirstName
        } else {
            throw ValidationError.invalidFirstName
        }
    }

    func validateLastName(lastname: String) throws {
        if lastname.matches(userNamesRegex) {
            print("Lastname matches with requirements")
        } else if lastname.count < minLength {
            throw ValidationError.invalidLastName
        } else {
            throw ValidationError.invalidLastName
        }
    }

    func validateEmail(email: String) throws {
        if email.matches(emailRegex) {
           print("Email matches with requirements")
        } else {
            throw ValidationError.invalidEmail
        }
    }

    func validatePassword (password: String) throws {
        if password.matches(comonRegex) {
            print("Password matches with requirements")
        } else if password.count < minLength {throw  ValidationError.invalidPassword} else {
            throw  ValidationError.invalidPassword
        }
    }
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
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
        }
    }
}
