//
//  BooksProvider.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

protocol BooksProvider: AnyObject {
    func getBooks(page: Int) async -> [Book]
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
    
    func getBooks(page: Int = 0) async -> [Book] {
        []
    }
}

final class BooksDBRepository {}
final class BooksWebRepository {}
