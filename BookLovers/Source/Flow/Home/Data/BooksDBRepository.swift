//
//  BooksDBRepository.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

final class BooksDBRepository {
    private var books = [Book]()
    private(set) var isEmpty = true
    
    func save(list: BookList) {
        self.isEmpty = list.items.isEmpty
        self.books = list.items
    }
    
    func fetchList() async throws -> BookList {
        BookList(
            kind: "",
            totalItems: books.count,
            items: books
        )
    }
    
}
