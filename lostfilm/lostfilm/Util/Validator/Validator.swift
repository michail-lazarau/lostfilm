//
//  Validator.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-08.
//

import Foundation

struct Validator<T> {
    let validate: (T) -> Bool
}

struct Validators {

    static var email: Validator<String> {
        return Validator<String> { text in
            let emailRegEx = RegEx.email.expression
            let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailValidation.evaluate(with: text) && !text.isEmpty
        }
    }

    static var password: Validator<String> {
        return Validator<String> { text in
            let passwordRegEx = RegEx.password.expression
            let passwordValidation = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordValidation.evaluate(with: text) && !text.isEmpty
        }
    }

    static var nickname: Validator<String> {
        return Validator<String> { text in
            let nicknameRegEx = RegEx.nickname.expression
            let nicknameValidation = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
            return nicknameValidation.evaluate(with: text) && !text.isEmpty
        }
    }
}
