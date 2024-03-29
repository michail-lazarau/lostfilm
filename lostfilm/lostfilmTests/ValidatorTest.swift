//
//  ValidatorTest.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-11-21.
//

import XCTest
@testable import lostfilm

final class ValidatorTest: XCTestCase {

    func test_ValidateEmailWithValidString() {
        XCTAssertTrue(Validators.email.validate("ValidEmail@gmail.com"))
    }

    func test_ValidateEmailWithInvalidString() {
        XCTAssertFalse(Validators.email.validate("InvalidEmail.com"))
    }

    func test_ValidateEmailWithEmptyString() {
        XCTAssertFalse(Validators.email.validate(""))
    }

    func test_ValidatePasswordWithValidString() {
        XCTAssertTrue(Validators.password.validate("ASPgo123"))
    }

    func test_ValidatePasswordWithInvalidString() {
        XCTAssertFalse(Validators.password.validate("Invalidpassword"))
    }

    func test_ValidatePasswordEmptyString() {
        XCTAssertFalse(Validators.password.validate(""))
    }

    func test_ValidateNicknameWithValidString() {
        XCTAssertTrue(Validators.nickname.validate("Name"))
    }

    func test_ValidateNicknameWithInvalidString() {
        XCTAssertFalse(Validators.nickname.validate("inv"))
    }

    func test_ValidateNicknameWithEmptySting() {
        XCTAssertFalse(Validators.nickname.validate(""))
    }
}
