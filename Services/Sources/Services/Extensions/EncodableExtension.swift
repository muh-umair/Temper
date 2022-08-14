//
//  EncodableExtension.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

// MARK: - EncodableExtension
extension Encodable {
    /// Returns `self` as `[String: Any]` using JSON serialization.
    var dictionary: [String: Any]? {
        guard let data = jsonData else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    /// Returns `self` as `Data` using `JSONEncoder`.
    var jsonData: Data? {
        try? JSONEncoder().encode(self)
    }
}
