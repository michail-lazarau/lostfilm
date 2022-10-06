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
    static let openEye = UIImage(named: "eye.circle") ?? UIImage()
    static let closeEye = UIImage(systemName: "eye.slash.circle") ?? UIImage()
}

enum Texts {

    case placeholders( _placeholders: Placeholders )
    case titles( _titles: Titles)
    case buttons( _buttons: Buttons)

    enum Placeholders {
        static let nickname = "Login(nickname)"
        static let email = "Please enter your E-mail"
        static let password = "Please enter your password"
        static let repeatPassword = "Please repeat password"
        static let namePlaceholder = "Please enter your name"
        static let surnamePlaceholder = "Please enter your surname"
    }

    enum Titles {
        static let logIn = "LOG IN"
        static let name = "Name"
        static let surname = "Surname"
        static let password = "Password"
        static let email = "Email"
        static let repeatPassword = "Repeat Password"
    }

    enum Buttons {
        static let logIn = "Log In"
        static let singUp = "Sing Up"
        static let forgotPassword = "Forgot Password?"
        static let ready = "Ready"
        static let alreadyHaveAnAccount = "Already have an account?"
    }
}
