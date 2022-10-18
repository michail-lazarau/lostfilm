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
        static let nickname = NSLocalizedString("Login(nickname)", comment: "")
        static let email = NSLocalizedString("Please enter your E-mail", comment: "")
        static let password =  NSLocalizedString("Please enter your password", comment: "")
        static let repeatPassword = NSLocalizedString("Please repeat password", comment: "")
        static let namePlaceholder = NSLocalizedString("Please enter your name", comment: "")
        static let surnamePlaceholder = NSLocalizedString("Please enter your surname", comment: "")
    }

    enum Titles {
        static let welcome = NSLocalizedString("WELCOM TO LOST FILM", comment: "")
        static let logIn =  NSLocalizedString( "LOG IN", comment: "")
        static let name = NSLocalizedString("Name", comment: "")
        static let surname = NSLocalizedString("Surname", comment: "")
        static let password = NSLocalizedString("Password", comment: "")
        static let email =  NSLocalizedString("Email", comment: "")
        static let repeatPassword = NSLocalizedString("Repeat Password", comment: "")
    }

    enum Buttons {
        static let singUp = NSLocalizedString( "Sing Up", comment: "")
        static let forgotPassword = NSLocalizedString( "Forgot Password?", comment: "")
        static let ready = NSLocalizedString("Ready", comment: "")
        static let alreadyHaveAnAccount = NSLocalizedString("Already have an account?", comment: "")
        static let buttonLogIn = NSLocalizedString("Enter", comment: "")
    }
}

enum Paddings {
    static let left = CGFloat(40)
    static let right = CGFloat( -40)
    static let top = CGFloat(8)
    static let bottom = CGFloat(-8)
}
