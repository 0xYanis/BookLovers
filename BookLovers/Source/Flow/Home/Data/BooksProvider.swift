//
//  BooksProvider.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

protocol BooksProvider: AnyObject {
    func getBooks() async -> Result<[Book], Error>
}

final class BooksProviderImpl: BooksProvider {
    private var dbRepository: BooksDBRepository
    private var webRepository: BooksWebRepository
    
    init(
        dbRepository: BooksDBRepository = BooksDBRepository(),
        webRepository: BooksWebRepository = BooksWebRepository()
    ) {
        self.dbRepository = dbRepository
        self.webRepository = webRepository
    }
    
    func getBooks() async -> Result<[Book], Error> {
        do {
            let books = try await dbRepository.isEmpty ? getBooksFromWeb() : getBooksFromDB()
            return .success(books)
        } catch {
            return .failure(error)
        }
    }
    
    private func getBooksFromDB() async throws -> [Book] {
        []
    }
    
    private func getBooksFromWeb() async throws -> [Book] {
        try await webRepository.loadBooks(from: URL(string: "https://www.googleapis.com/books/v1/volumes?q=swift"))
    }
}
