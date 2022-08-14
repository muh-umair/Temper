//
//  L10n.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

enum L10n: String {
    case network_error_undefined
    case network_error_invalid_request
    case network_error_invalid_response
    case network_error_failed_decoding
    case network_error_timeout
    case network_error_no_network
}

// MARK: - Localizable
extension L10n {
    var localized: String {
        return NSLocalizedString(self.rawValue, bundle: .module, comment: "")
    }
}

