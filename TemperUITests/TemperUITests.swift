//
//  TemperUITests.swift
//  TemperUITests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest

final class TemperUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["isStubEnabled"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
}

extension TemperUITests {
    
    func test_whenLoginButtonClicked_thenLoginViewOpens() throws {
        ShiftListPage(app: app)
            .tapLogin()
            .checkPageExistence()
    }
    
    func test_whenSignupButtonClicked_thenSignupViewOpens() throws {
        ShiftListPage(app: app)
            .tapSignup()
            .checkPageExistence()
    }

    func test_whenMapButtonClicked_thenMapViewOpens() throws {
        ShiftListPage(app: app)
            .tapMap()
            .checkPageExistence()
    }
    
    func test_whenFiltersButtonClicked_thenFilterViewOpens() throws {
        ShiftListPage(app: app)
            .tapFilters()
            .checkPageExistence()
    }
}
