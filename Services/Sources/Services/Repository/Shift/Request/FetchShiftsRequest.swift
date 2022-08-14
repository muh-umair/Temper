//
//  FetchShiftsRequest.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Request to fetch shifts.
public struct FetchShiftsRequest: Codable {
    public let date: Date
    
    public init(date: Date) {
        self.date = date
    }
        
    enum CodingKeys: String, CodingKey {
        case date = "filer[date]"
    }
    
    public func encode(to encoder: Encoder) throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formatter.string(from: date), forKey: .date)
    }
}
