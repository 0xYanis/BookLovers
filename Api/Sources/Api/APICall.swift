//
//  APICall.swift
//  BookLovers
//
//  Created by Yanis on 19.03.2024.
//

import Foundation

public typealias HTTPCode = Int
public typealias HTTPCodes = Range<HTTPCode>

public extension HTTPCodes {
    static let success = 200 ..< 300
}

public protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    
    func body() throws -> Data?
}

public extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path)
        else { throw APIError.invalidURL }
        var request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
