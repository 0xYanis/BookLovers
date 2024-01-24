//
//  BooksWebRepository.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

final class BooksWebRepository {
    
    func loadBooks(from url: URL?) async throws -> [Book] {
        guard let url = url else { return [] }
        let (data, response) = try await URLSession.shared.data(from: url)
        print(response)
        print(String(data: data, encoding: .utf8) ?? "NONE")
        return []
    }
    
}
