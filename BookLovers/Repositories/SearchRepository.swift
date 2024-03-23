//
//  SearchRepository.swift
//  BookLovers
//
//  Created by Yanis on 23.03.2024.
//

import Foundation
import Combine

protocol SearchRepository: WebRepository {
    func search(query: String, count: Int, startIndex: Int) -> AnyPublisher<DTOBookList, Error>
    func search(id: String) -> AnyPublisher<DTOBook, Error>
}

struct SearchRepositoryImpl: SearchRepository {
    var session: URLSession
    var baseURL: String
    var bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    func search(query: String, count: Int, startIndex: Int) -> AnyPublisher<DTOBookList, Error> {
        return call(endpoint: API.searchBooks(query, count, startIndex))
    }
    
    func search(id: String) -> AnyPublisher<DTOBook, Error> {
        return call(endpoint: API.searchBook(id))
    }
}

extension SearchRepositoryImpl {
    enum API {
        case searchBooks(_ query: String,_ count: Int,_ startIndex: Int)
        case searchBook(_ id: String)
    }
}

extension SearchRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .searchBooks(let query, let count, let startIndex):
            return "/volumes?q=\(query)&maxResults=\(count)&startIndex=\(startIndex)"
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
