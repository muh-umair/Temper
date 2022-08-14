//
//  Constant.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

struct Constant {
    /// Constants for networking
    struct Network {
        /// Base URL for APIs
        static let ApiBaseURL = "https://temper.works"
        
        /// Default timeout for network requests
        static let timeout = TimeInterval(30)
        
        /// Default configuration for `URLSession`
        static var configuration: URLSessionConfiguration {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = .init()
            configuration.timeoutIntervalForRequest = Network.timeout
            configuration.timeoutIntervalForResource = Network.timeout
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return configuration
        }
        
        /// Should use stub instead of actual data from network. Injected in launch arguments e.g. during automation testing.
        static var isStubEnabled: Bool {
            ProcessInfo.processInfo.arguments.contains("isStubEnabled")
        }
        
        /// JSON decoder to decode data
        static var decoder: JSONDecoder {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        }
    }    
}
