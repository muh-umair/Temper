//
//  Networking.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Networking protocol to which concrete networking must confirm.
public protocol NetworkingProtocol {
    
    /// Configure networking.
    ///
    /// - parameter isStubEnabled: If `true` use mock data otherwise use actual data from network.
    /// - parameter configuration: `URLSessionConfiguration` for the actual network request.
    func configure(isStubEnabled: Bool, configuration: URLSessionConfiguration)
    
    /// Execute network request and decode response to `T` type.
    ///
    /// - parameter endpoint: Concrete `Endpoint` from where data is fetched.
    /// - returns: Decoded result as `T` type.
    /// - throws: An error if any value throws an error during execution.
    func execute<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

/// Networking implementation which will be used by different repositories.
public final class Networking {
    
    /// Shared instance
    public static let shared = Networking()
    
    // Should use mock data or actual request from network.
    private var isStubEnabled: Bool = false
    
    // URL session for actual requests.
    private var urlSession: URLSession = URLSession(configuration: .default)
    
    private init() {
    }
}

// MARK: - NetworkingProtocol
extension Networking: NetworkingProtocol {
    
    /// Configure networking.
    ///
    /// - parameter isStubEnabled: If `true` use mock data otherwise use actual data from network.
    /// - parameter configuration: `URLSessionConfiguration` for the actual network request.
    public func configure(isStubEnabled: Bool, configuration: URLSessionConfiguration) {
        self.isStubEnabled = isStubEnabled
        self.urlSession = URLSession(configuration: configuration)
    }
    
    /// Execute network request and decode response to `T` type.
    ///
    /// - parameter endpoint: Concrete `Endpoint` from where data is fetched.
    /// - returns: Decoded result as `T` type.
    /// - throws: `NetworkError` if any value throws an error during execution.
    public func execute<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await dataTask(endpoint)
        return try decode(with: data)
    }
}

// MARK: - Helpers
private extension Networking {
    /// Fetch data for `endpoint`.
    ///
    /// Use mock data if `isStubEnabled` is `true`; otherwise use `urlSession` to fetch data from network.
    ///
    /// - parameter endpoint: Concrete `Endpoint` from where data is fetched.
    /// - returns: Data from subbing or network based on configuration.
    /// - throws: `NetworkError.invalidRequest` if endpoint can't provide proper `URLRequest`.
    /// - throws: `NetworkError(error:)` describing `urlSession` error if there is any.
    private func dataTask(_ endpoint: Endpoint) async throws -> Data {
        guard !isStubEnabled else { return endpoint.mockData }
        guard let urlRequest = endpoint.urlRequest else { throw NetworkError.invalidRequest }
        
        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            return data
        } catch let error {
            throw NetworkError(error: error)
        }
    }
    
    /// Decode data to `T` type.
    ///
    /// - parameter data: Data to be decoded.
    /// - returns: Decoded data as `T` type.
    /// - throws: `NetworkError.failedDecoding` if decoding fails.
    private func decode<T: Decodable>(with data: Data) throws -> T {
        do {
            let response = try Constant.Network.decoder.decode(T.self, from: data)
            return response
        } catch {
            throw NetworkError.failedDecoding
        }
    }
}
