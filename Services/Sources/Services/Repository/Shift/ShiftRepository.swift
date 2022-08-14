//
//  ShiftRepository.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Protocol to define all methods for shift repository
public protocol ShiftRepositoryProtocol {
    /// Fetch shifts
    ///
    /// - parameter request: Request object to define which shifts to fetch.
    /// - returns: `FetchShiftsResponse` containing the requested shifts.
    /// - throws: An error if there is any
    func fetchShifts(_ request: FetchShiftsRequest) async throws -> FetchShiftsResponse
}

/// Shift repository to manage data using networking
public final class ShiftRepository: ShiftRepositoryProtocol {
    // Networking
    private let networking: NetworkingProtocol
    
    public init(networking: NetworkingProtocol = Networking.shared) {
        self.networking = networking
    }
    
    /// Fetch shifts
    ///
    /// - parameter request: Request object to define which shifts to fetch.
    /// - returns: `FetchShiftsResponse` containing the requested shifts.
    /// - throws: An error if networking gives an error.
    public func fetchShifts(_ request: FetchShiftsRequest) async throws -> FetchShiftsResponse {
        try await networking.execute(ShiftEndpoint.fetchShifts(request))
    }
}
