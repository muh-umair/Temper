//
//  Shift.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Struct defining a shift. Contains job, address, earnings, etc.
public struct Shift: Decodable {
    public let id: String
    public let startsAt: Date
    public let endsAt: Date
    public let earningsPerHourCurrencyValue: String
    public let earningsPerHourAmountValue: Double
    public let job: Job
    
    enum CodingKeys: String, CodingKey {
        case id
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case earningsPerHour = "earnings_per_hour"
        case job
    }
    
    enum EarningsPerHourKeys: String, CodingKey {
        case currency
        case amount
    }
    
    public init(id: String, startsAt: Date, endsAt: Date, earningsPerHourCurrencyValue: String, earningsPerHourAmountValue: Double, job: Job) {
        self.id = id
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.earningsPerHourCurrencyValue = earningsPerHourCurrencyValue
        self.earningsPerHourAmountValue = earningsPerHourAmountValue
        self.job = job
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let earningsPerHourValues = try values.nestedContainer(keyedBy: EarningsPerHourKeys.self, forKey: .earningsPerHour)
        let earningsPerHourCurrencyValue = try earningsPerHourValues.decode(String.self, forKey: .currency)
        let earningsPerHourAmountValue = try earningsPerHourValues.decode(Double.self, forKey: .amount)
        
        self.init(
            id: try values.decode(String.self, forKey: .id),
            startsAt: try values.decode(Date.self, forKey: .startsAt),
            endsAt: try values.decode(Date.self, forKey: .endsAt),
            earningsPerHourCurrencyValue: earningsPerHourCurrencyValue,
            earningsPerHourAmountValue: earningsPerHourAmountValue,
            job: try values.decode(Job.self, forKey: .job)
        )
    }
}

