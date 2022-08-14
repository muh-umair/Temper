//
//  FetchShiftsRequest.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Request to fetch shifts.
struct FetchShiftsRequest: Codable {
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case date = "filer[date]"
    }
    
    func encode(to encoder: Encoder) throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formatter.string(from: date), forKey: .date)
    }
}
