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
        trimmedString.isEmpty ? ValidationResult.init() : .init(error: "add Text From Enum/ zx kak [omyny")
    }

    var isNotEmpty: ValidationResult {
        !trimmedString.isEmpty ? ValidationResult.init() : .init(error: "Line is empty")
    }

    var isEmail: ValidationResult {

        let isNotEmptyString = isNotEmpty

        if isNotEmptyString.isSuccess {
            let emailRegEx = RegEx.email.expression
            let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
            return emailValidation ? ValidationResult.init() : .init(error: "Email Error")

        } else {
            return isNotEmptyString
        }
    }
}
