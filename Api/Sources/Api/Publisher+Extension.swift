//
//  Publisher+Extension.swift
//  
//
//  Created by Yanis on 26.03.2024.
//

import Foundation
import Combine

public extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        return tryMap {
            assert(!Thread.isMainThread)
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            return $0.0
        }
        .eraseToAnyPublisher()
    }
    
    func requestJSON<Value>(
        httpCodes: HTTPCodes
    ) -> AnyPublisher<Value, Error> where Value : Decodable {
        return requestData(httpCodes: httpCodes)
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
