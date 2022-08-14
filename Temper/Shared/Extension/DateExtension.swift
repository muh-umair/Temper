//
//  DateExtension.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

// MARK: - DateExtension
extension Date {
    /// Compute new date by adding calendar component
    ///
    /// - parameter component: component to add e.g. .day
    /// - parameter value: how much to add
    /// - returns: New date or nil if there is an error
    func add(_ component: Calendar.Component, _ value: Int) -> Date? {
        Calendar.current.date(byAdding: component, value: value, to: self)
    }
}
