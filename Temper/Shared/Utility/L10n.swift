//
//  L10n.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

enum L10n: String {
    case map_title
    case filters_title
    case login_title
    case signup_title
    case shift_list_map_button
    case shift_list_filters_button
    case shift_list_login_button
    case shift_list_signup_button
    case loading
}

// MARK: - Localizable
extension L10n {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
