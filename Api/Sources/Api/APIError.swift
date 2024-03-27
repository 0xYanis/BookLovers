//
//  APIError.swift
//  
//
//  Created by Yanis on 26.03.2024.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case httpCode(_ code: HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .httpCode(let code):
            return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse:
            return "Unexpected response from server"
        }
    }
}
