//
//  ShiftEndpoint.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Endpoint for all requests related to shift
enum ShiftEndpoint {
    /// Fetch shifts list
    case fetchShifts(FetchShiftsRequest)
}

// MARK: - Confirming to Endpoint protocol
extension ShiftEndpoint: Endpoint {
    var baseURL: String {
        return Constant.Network.ApiBaseURL
    }
    
    var path: String {
        switch self {
        case .fetchShifts: return "/api/v3/shifts"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchShifts: return .get
        }
    }
    
    var headers: ReaquestHeaders? {
        switch self {
        case .fetchShifts: return nil
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .fetchShifts(let request): return request.dictionary
        }
    }
    
    var body: Encodable? {
        switch self {
        case .fetchShifts: return nil
        }
    }
    
    var mockData: Data {
        switch self {
        case .fetchShifts: return loadData(from: MockDataFileName.fetchShifts.rawValue)
        }
    }
}

// MARK: - Define mock file names
private extension ShiftEndpoint {
    enum MockDataFileName: String {
        case fetchShifts = "fetch_shifts_response"
    }
}
