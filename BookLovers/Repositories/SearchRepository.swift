//
//  SearchRepository.swift
//  BookLovers
//
//  Created by Yanis on 23.03.2024.
//

import Foundation
import Combine

protocol SearchRepository: WebRepository {
    func search(query: String) -> AnyPublisher<DTOBookList, Error>
    func search(id: String) -> AnyPublisher<DTOBook, Error>
}

struct SearchRepositoryImpl: SearchRepository {
    var session: URLSession
    var baseURL: String
    var bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    func search(query: String) -> AnyPublisher<DTOBookList, Error> {
        return call(endpoint: API.searchBooks(query))
    }
    
    func search(id: String) -> AnyPublisher<DTOBook, Error> {
        return call(endpoint: API.searchBook(id))
    }
}

extension SearchRepositoryImpl {
    enum API {
        case searchBooks(_ query: String)
        case searchBook(_ id: String)
    }
}

extension SearchRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .searchBooks(let query):
            return "/volumes?q=\(query)"
        case .searchBook(let id):
            return "/\(id)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
