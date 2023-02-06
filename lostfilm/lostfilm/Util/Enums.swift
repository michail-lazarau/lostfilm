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
    static let addPhotoButton = UIImage(systemName: "person.crop.circle.badge.plus") ?? UIImage()
}

enum Texts {

    case placeholders( _placeholders: Placeholders )
    case titles( _titles: Titles)
    case buttons( _buttons: Buttons)
    case rulesTexts( _rulesTexts: RulesTexts)

    enum Placeholders {
        static let nickname = NSLocalizedString("Login(nickname)", comment: "")
        static let email = NSLocalizedString("Please enter your E-mail", comment: "")
        static let password =  NSLocalizedString("Please enter your password", comment: "")
        static let repeatPassword = NSLocalizedString("Please repeat password", comment: "")
        static let namePlaceholder = NSLocalizedString("Please enter your name", comment: "")
        static let surnamePlaceholder = NSLocalizedString("Please enter your surname", comment: "")
        static let captcha = NSLocalizedString("Please enter captcha", comment: "")
        static let male = NSLocalizedString("Male", comment: "")
        static let female = NSLocalizedString("Female", comment: "")
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
        static let aboutYourself = NSLocalizedString("About yourself", comment: "")
        static let gender = NSLocalizedString("Please enter your gender", comment: "")
        static let age = NSLocalizedString("Enter your age", comment: "")
        static let country = NSLocalizedString("Country", comment: "")
        static let city = NSLocalizedString("City", comment: "")
        static let selectProfilePhoto = NSLocalizedString("Upload your profile picture", comment: "")
        static let takePhoto = NSLocalizedString("Take a photo", comment: "")
        static let selectPhoto = NSLocalizedString("Select Photo", comment: "")
        static let photoLibraryAccessD = NSLocalizedString("Select Photo", comment: "")
        static let cameraAccessDeniedTitle = NSLocalizedString("Camera Access Denied", comment: "")
        static let cameraAccessDeniedMessage = NSLocalizedString("Please Add Access to camera", comment: "")
        static let photoLibraryAccessDeniedTitle = NSLocalizedString("Photo Library Access Denied", comment: "")
        static let photoLibraryAccessDeniedMessage = NSLocalizedString("Please Add Access to photo library", comment: "")
    }

    enum Buttons {
        static let singUp = NSLocalizedString( "Sing Up", comment: "")
        static let forgotPassword = NSLocalizedString( "Forgot Password?", comment: "")
        static let ready = NSLocalizedString("Ready", comment: "")
        static let alreadyHaveAnAccount = NSLocalizedString("Already have an account?", comment: "")
        static let dontHaveAnAccount = NSLocalizedString("Don't have an account?", comment: "")
        static let buttonLogIn = NSLocalizedString("Enter", comment: "")
        static let next = NSLocalizedString("Next", comment: "")
        static let done = NSLocalizedString("Done", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let settings = NSLocalizedString("Settings", comment: "")
    }

    enum RulesTexts {
        static let ruleLinkText = NSLocalizedString("To find out more please visit our website", comment: "")
        static let hyperLink = NSLocalizedString("Site Rules", comment: "")
    }
}

enum ValidationErrors {
    static let invalidEmail = NSLocalizedString("InvalidEmail", comment: "")
    static let invalidPassword = NSLocalizedString("Password must be between 4 and 8 digits long and include at least one numeric digit.", comment: "")
    static let invalidNickName = NSLocalizedString("Title cased words within a Camel cased variable name. So it will match 'First' and 'Name' within 'strFirstName'.", comment: "")
    static let invalidName = NSLocalizedString("Title cased words within a Camel cased variable name. So it will match 'First' and 'Name' within 'strFirstName'.", comment: "")
    static let invalidSurname = NSLocalizedString("Title cased words within a Camel cased variable name. So it will match 'First' and 'Surname' within 'strFirstSurnameName'.", comment: "")
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
    static let validNickname = NSLocalizedString("Nickname confirmed", comment: "")
    static let validName = NSLocalizedString("Name confirmed", comment: "")
    static let validSurname = NSLocalizedString("Surname confirmed", comment: "")

}

enum ValidationError: Error {
    case invalidUserName
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case invalidRepeatPassword
    case invalidPhone
    case invalidNickname
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
        case .invalidNickname:
            return NSLocalizedString("Invalid nickName format", comment: "")
        case .invalidRepeatPassword:
            return NSLocalizedString("Passwords must be the same", comment: "")

        }
    }
}

enum RegEx {
    case email
    case password
    case nickname
}

extension RegEx {
    var expression: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            return "^(?=.*\\d).{4,8}$"
        case .nickname:
            return "[A-Z][a-z]+"
        }
    }
}

enum Links {
    static let rules = "https://www.lostfilm.tv/rules/"
}
