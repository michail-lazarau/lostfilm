//
//  ValidationType.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-03.
//

import Foundation

//enum ValidationType {
//    case isEmpty
//    case isNotEmpty
//    case email
//    case password
//}
//
//extension ValidationType {
//
//    func isValid(_ text: String) -> ValidationResult {
//        switch self {
//        case .isEmpty:
//            return text.isEmpty
//        case .isNotEmpty:
//            return text.isNotEmpty
//        case .email:
//            return text.isEmail
//        case .password:
//            return text.isPassword
//        }
//    }
//}

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
            return "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
        }
    }
}
