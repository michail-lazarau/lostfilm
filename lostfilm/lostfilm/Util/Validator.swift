//
//  Validator.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-10-26.
//

import Foundation

enum ValidatorError: Error {
    case invalidFirstName
    case invalidLastName
    case invalidNickname
    case invalidEmail
    case invalidPassword
}

final class Validator {
    private let minNickNameLength = 4
    private let minPasswordLength = 6
    private let maxFirstNameLength = 16
    private let maxLastNameLength = 24

    private lazy var nickNamesRegex = "^[a-zA-Z0-9_]{1,13}${\(minNickNameLength)}"
    private lazy var emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private lazy var passwordRegex = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){\(minPasswordLength)}"
    private lazy var firstNameRegex = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){\(maxFirstNameLength)}"
    private lazy var lastNameRegex = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){\(maxLastNameLength)}"

    func validateNickName(nickName: String) throws {
        if nickName.matches(nickNamesRegex) {
            print("NickName matches with requirements")
    }
        else if nickName.count < minNickNameLength {
            throw ValidatorError.invalidNickname
        } else {
            throw ValidatorError.invalidNickname
        }
    }

    func validateFirstName( firstName: String) throws {
        if firstName.matches(firstNameRegex) {
            print("FirstName matches with requirements")
        }
        else if firstName.count > maxFirstNameLength {
            throw ValidatorError.invalidNickname
        } else {
            throw ValidatorError.invalidNickname
        }
    }
}

extension ValidatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return NSLocalizedString("FirstName Error", comment: "")
        case .invalidLastName:
            return NSLocalizedString("LastName Error", comment: "")
        case .invalidNickname:
            return NSLocalizedString("Nick Name Error", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email Error", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Password Error", comment: "")
        }
    }
}
