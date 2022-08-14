//
//  Endpoint.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// Type alias used for HTTP request headers.
public typealias ReaquestHeaders = [String: String]

/// Type alias used for HTTP request parameters. Used for query parameters for GET requests and in the HTTP body for POST, PUT and PATCH requests.
public typealias RequestParameters = [String : Any]

/// HTTP request methods.
public enum RequestMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP DELETE
    case delete = "DELETE"
}

/// Protocol to which the HTTP requests must conform.
public protocol Endpoint {
    
    /// Base URL of the environment.
    var baseURL: String { get }
    
    /// Path that will be appended to API's base URL.
    var path: String { get }
    
    /// HTTP method.
    var method: RequestMethod { get }
    
    /// HTTP headers
    var headers: ReaquestHeaders? { get }
    
    /// Query parameters.
    var parameters: RequestParameters? { get }
    
    /// HTTP body.
    var body: Encodable? { get }
    
    /// Mock data.
    var mockData: Data { get }
}

// MARK: - Data
extension Endpoint {
    /// Returns data from a given file.
    ///
    /// - parameter fileName: A sting value of file name. File should be a json.
    /// - returns: Data from file or empty data if can't read file.
    func loadData(from fileName: String) -> Data {
        if let bundle = Bundle.module.url(forResource: fileName, withExtension: "json") {
            return (try? Data(contentsOf: bundle)) ?? Data()
        }
        return Data()
    }
}

// MARK: - UrlRequest
extension Endpoint {
    /// Returns an optional `URLRequest`.
    var urlRequest: URLRequest? {
        // Create the base URL.
        guard let url = url else {
            return nil
        }
        // Create a request with that URL.
        var request = URLRequest(url: url)
        
        // Append all related properties.
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body?.jsonData
        
        return request
    }
    
    /// Returns a `URL` with given properties.
    private var url: URL? {
        // Create a URLComponents instance to compose the url.
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        // Add the request path to the existing base URL path.
        urlComponents.path = urlComponents.path + path
        // Add query items to the request URL.
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    /// Returns array of `URLQueryItem` from parameters.
    private var queryItems: [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }
        // Convert parameters to query items.
        return parameters.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
}
