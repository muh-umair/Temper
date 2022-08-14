//
//  MockShiftRepository.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import Services

final class MockShiftRepository: ShiftRepositoryProtocol {
    var shifts: [Shift]?
    var error: Error?
    
    func fetchShifts(_ request: FetchShiftsRequest) async throws -> FetchShiftsResponse {
        if let error = error {
            throw error
        }
        return FetchShiftsResponse(shifts: shifts ?? [], count: shifts?.count ?? 0)
    }
}
