//
//  Pages.swift
//  TemperUITests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest

/// Structure to define a view for testing
class Page {
    // MARK: - Properties
    /// Launched application reference
    let app: XCUIApplication
    
    // MARK: - Initializer
    init(app: XCUIApplication) {
        self.app = app
    }
    
    /// Check existence of an element and fails the test if it doesn't exist.
    ///
    /// - parameter element: An element whose existence should be checked.
    /// - parameter time: How much should the function wait for existence. Default is 2 seconds.
    /// - returns: `Self` the page that calls this function
    @discardableResult
    func checkExistence(_ element: XCUIElement, time: TimeInterval = 2.0) -> Self {
        if element.waitForExistence(timeout: time) == false {
            XCTFail()
        }
        return self
    }
    
    /// Check existence of a page and fails the test if it doesn't exist or if no element is available to check. Children should override `getPageExistenceCheckElement()`
    ///
    /// - parameter : none
    /// - returns: `Self` the page that calls this function
    @discardableResult
    func checkPageExistence() -> Self {
        guard let element = getPageExistenceCheckElement() else {
            XCTFail()
            return self
        }
        checkExistence(element)
        return self
    }
    
    /// Provide element to check existence of a page.
    ///
    /// - parameter : none
    /// - returns: Optional `XCUIElement`, the element which should be used to check page existence.
    func getPageExistenceCheckElement() -> XCUIElement? {
        return nil
    }
}
