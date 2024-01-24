//
//  BooksProvider.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

protocol BooksProvider: AnyObject {
    func getBooks() async -> Result<BookList, Error>
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
    
    func getBooks() async -> Result<BookList, Error> {
        do {
            let list = try await dbRepository.isEmpty ? getListFromWeb() : getListFromDB()
            return .success(list)
        } catch {
            return .failure(error)
        }
    }
    
    private func saveList(_ list: BookList) {
        if list.items.isEmpty == false {
            dbRepository.save(list: list)
        }
    }
    
    private func getListFromDB() async throws -> BookList {
        try await dbRepository.fetchList()
    }
    
    private func getListFromWeb() async throws -> BookList {
        let list = try await webRepository.fetchList()
        saveList(list)
        return list
    }
}
