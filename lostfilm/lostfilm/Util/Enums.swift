//
//  Enums.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation

enum Icons {
    static let person = UIImage(systemName: "person") ?? UIImage()
    static let mail = UIImage(systemName: "mail") ?? UIImage()
    static let password = UIImage(systemName: "lock") ?? UIImage()
    static let captcha = UIImage(systemName: "repeat") ?? UIImage()
}

enum Texts {

    case placeholders( _placeholders: Placeholders )
    case titles( _titles: Titles)
    case buttons( _buttons: Buttons)

    enum Placeholders {
        static let nickname = NSLocalizedString("Login(nickname)", comment: "")
        static let email = NSLocalizedString("Please enter your E-mail", comment: "")
        static let password =  NSLocalizedString("Please enter your password", comment: "")
        static let repeatPassword = NSLocalizedString("Please repeat password", comment: "")
        static let namePlaceholder = NSLocalizedString("Please enter your name", comment: "")
        static let surnamePlaceholder = NSLocalizedString("Please enter your surname", comment: "")
        static let captcha = NSLocalizedString("Please enter captcha", comment: "")
    }

    enum Titles {
        static let welcome = NSLocalizedString("WELCOM TO LOST FILM", comment: "")
        static let logIn =  NSLocalizedString( "LOG IN", comment: "")
        static let name = NSLocalizedString("Name", comment: "")
        static let surname = NSLocalizedString("Surname", comment: "")
        static let password = NSLocalizedString("Password", comment: "")
        static let email =  NSLocalizedString("Email", comment: "")
        static let repeatPassword = NSLocalizedString("Repeat Password", comment: "")
        static let captcha = NSLocalizedString("Captcha", comment: "")
    }

    enum Buttons {
        static let singUp = NSLocalizedString( "Sing Up", comment: "")
        static let forgotPassword = NSLocalizedString( "Forgot Password?", comment: "")
        static let ready = NSLocalizedString("Ready", comment: "")
        static let alreadyHaveAnAccount = NSLocalizedString("Already have an account?", comment: "")
        static let buttonLogIn = NSLocalizedString("Enter", comment: "")
    }

    enum ValidationErrors {
        static let invalidEmail = NSLocalizedString("InvalidEmail", comment: "")
        static let invalidPassword = NSLocalizedString("InvalidPassword", comment: "")
    }
}

enum Paddings {
    static let left = CGFloat(40)
    static let right = CGFloat( -40)
    static let top = CGFloat(8)
    static let bottom = CGFloat(-8)
}

enum ValidationConfirmation {
    static let validEmail = NSLocalizedString("Email confirmed", comment: "")
    static let validPassword = NSLocalizedString("Password confirmed", comment: "")
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
    var errorDescription: String? {
        switch self {
        case .invalidUserName:
            return NSLocalizedString("Invalid Username format", comment: "")
        case .invalidFirstName:
            return NSLocalizedString("Invalid Firstname format", comment: "")
        case .invalidLastName:
            return NSLocalizedString("Invalid Lastname format.", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid e-mail format.", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Invalid password format", comment: "")
        case .invalidPhone:
            return NSLocalizedString("Invalid Phone format", comment: "")

        }
    }
}

enum RegEx {
    case email
    case password
}

extension RegEx {
    var expression: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            return "^(?=.*\\d).{4,8}$"
        }
    }
}
