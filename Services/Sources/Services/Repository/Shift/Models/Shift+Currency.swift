//
//  Shift+Currency.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

// MARK: - Currency related to Shift earnings.
public extension Shift {
    enum Currency {
        case euro
        case unitedStatesDollar
        case unknown
        
        public init(shorthand: String) {
            switch shorthand {
            case "EUR":
                self = .euro
            case "USD":
                self = .unitedStatesDollar
            default:
                self = .unknown
            }
        }
        
        public var sign: String {
            switch self {
            case .euro:
                return "€"
            case .unitedStatesDollar:
                return "$"
            case .unknown:
                return "?"
            }
        }
    }
}
