//
//  ShiftPage.swift
//  TemperUITests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest

/// Shift list page
class ShiftListPage: Page {
    // MARK: - Properties to access UI elements
    private var loginButton: XCUIElement { app.buttons["ShiftsList.LoginButton"] }
    private var signupButton: XCUIElement { app.buttons["ShiftsList.SignupButton"] }
    private var filtersButton: XCUIElement { app.buttons["ShiftsList.FiltersButton"] }
    private var mapButton: XCUIElement { app.buttons["ShiftsList.MapButton"] }
    
    /// Tap on login button.
    ///
    /// - parameter : none
    /// - returns: `LoginPage`
    @discardableResult func tapLogin() -> LoginPage {
        loginButton.tap()
        return LoginPage(app: app)
    }
    
    /// Tap on signup button.
    ///
    /// - parameter : none
    /// - returns: `SignupPage`
    @discardableResult
    func tapSignup() -> SignupPage {
        signupButton.tap()
        return SignupPage(app: app)
    }
    
    /// Tap on filters button.
    ///
    /// - parameter : none
    /// - returns: `FilterPage`
    @discardableResult
    func tapFilters() -> FilterPage {
        filtersButton.tap()
        return FilterPage(app: app)
    }
    
    /// Tap on map button.
    ///
    /// - parameter : none
    /// - returns: `MapPage`
    @discardableResult
    func tapMap() -> MapPage {
        mapButton.tap()
        return MapPage(app: app)
    }
}

/// Filter page
class FilterPage: Page {
    // MARK: - Properties to access UI elements
    private var titleText: XCUIElement { app.staticTexts["Filter.Title"] }
    
    // Use titleText to check page existence
    override func getPageExistenceCheckElement() -> XCUIElement? {
        return titleText
    }
}

/// Map page
class MapPage: Page {
    // MARK: - Properties to access UI elements
    private var titleText: XCUIElement { app.staticTexts["Map.Title"] }
    
    // Use titleText to check page existence
    override func getPageExistenceCheckElement() -> XCUIElement? {
        return titleText
    }
}

