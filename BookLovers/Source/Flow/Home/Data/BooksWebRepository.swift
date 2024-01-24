//
//  BooksWebRepository.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

final class BooksWebRepository {
    
    func fetchList() async throws -> BookList {
        let debugUrl = URL(string: "https://www.googleapis.com/books/v1/volumes?q=recommender")!
        let (data, _) = try await URLSession.shared.data(from: debugUrl)
        let decoder = JSONDecoder()
        let list = try decoder.decode(BookList.self, from: data)
        return list
    }
}
