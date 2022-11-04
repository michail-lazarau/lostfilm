//
//  Extention+String.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-03.
//

import Foundation

extension String {
    var trimmedString: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isEmpty: ValidationResult {
        trimmedString.isEmpty ? ValidationResult.init() : .init(error: "empty string")
    }

    var isNotEmpty: ValidationResult {
        !trimmedString.isEmpty ? ValidationResult.init() : .init(error: "empty string")
    }

    var isEmail: ValidationResult {
        let isNotEmptyString = isNotEmpty

        if isNotEmptyString.isSuccess {
            let emailRegEx = RegEx.email.expression
            let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
            return emailValidation ? ValidationResult.init() : .init(error: Texts.ValidationErrors.invalidEmail)
        } else {
            return isNotEmptyString
        }
    }

    var isPassword: ValidationResult {
        let isNotEmptyString = isNotEmpty

        if isNotEmptyString.isSuccess {
            let passwordRegEx = RegEx.password.expression
            let passwordValidation = NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: self)
            if passwordValidation {
                return .init()
            } else {
                return .init(error: Texts.ValidationErrors.invalidPassword)
            }
        } else {
            return isNotEmptyString
        }
    }
}
