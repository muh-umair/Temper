//
//  NetworkError.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Network error to describe different conditions that can happen.
public enum NetworkError: Error, LocalizedError {
    case undefined
    case invalidRequest
    case invalidResponse
    case failedDecoding
    case timeout
    case noNetwork
    
    public var errorDescription: String? {
        switch self {
        case .undefined: return L10n.network_error_undefined.localized
        case .invalidRequest: return L10n.network_error_invalid_request.localized
        case .invalidResponse: return L10n.network_error_invalid_response.localized
        case .failedDecoding: return L10n.network_error_failed_decoding.localized
        case .timeout: return L10n.network_error_timeout.localized
        case .noNetwork: return L10n.network_error_no_network.localized
        }
    }
}

extension NetworkError {
    /// Convert `Error` to `NetworkError`
    init(error: Error?) {
        if let error = error as? NetworkError {
            self = error
        } else {
            switch error?._code {
            case NSURLErrorTimedOut:
                self = .timeout
            case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                self = .noNetwork
            default:
                self = .undefined
            }
        }
    }
}
