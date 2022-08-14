//
//  FetchShiftsResponse.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Response to describe `FetchShiftsResult`.
public struct FetchShiftsResponse: Decodable {
    public let shifts: [Shift]
    public let count: Int
    
    enum CodingKeys: String, CodingKey {
        case data
        case count = "aggregations"
    }
    
    enum AggregationsKeys: String, CodingKey {
        case count
    }
    
    public init(shifts: [Shift], count: Int) {
        self.shifts = shifts
        self.count = count
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let aggregationsValues = try values.nestedContainer(keyedBy: AggregationsKeys.self, forKey: .count)
        
        self.init(
            shifts: try values.decode([Shift].self, forKey: .data),
            count: try aggregationsValues.decode(Int.self, forKey: .count)
        )
    }
}
