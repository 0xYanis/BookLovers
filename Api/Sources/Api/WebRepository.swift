//
//  WebRepository.swift
//  BookLovers
//
//  Created by Yanis on 19.03.2024.
//

import Foundation
import Combine

public protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

public extension WebRepository {
    func call<Value>(
        endpoint: APICall,
        httpCodes: HTTPCodes = .success
    ) -> AnyPublisher<Value, Error> where Value : Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
