//
//  AuthPage.swift
//  TemperUITests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest

/// Login page
class LoginPage: Page {
    // MARK: - Properties to access UI elements
    private var titleText: XCUIElement { app.staticTexts["Login.Title"] }
    
    // Use titleText to check page existence
    override func getPageExistenceCheckElement() -> XCUIElement? {
        return titleText
    }
}

/// Sign up page
class SignupPage: Page {
    // MARK: - Properties to access UI elements
    private var titleText: XCUIElement { app.staticTexts["Signup.Title"] }
    
    // Use titleText to check page existence
    override func getPageExistenceCheckElement() -> XCUIElement? {
        return titleText
    }
}
