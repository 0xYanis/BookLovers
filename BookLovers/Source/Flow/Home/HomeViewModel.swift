//
//  HomeViewModel.swift
//  BookLovers
//
//  Created by Yanis on 24.01.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    private var booksProvider: BooksProvider
    
    init(booksProvider: BooksProvider = BooksProviderImpl()) {
        self.booksProvider = booksProvider
    }
    
    func showList() {
        Task {
            let booksList = await booksProvider.getBooks(page: 0)
            await MainActor.run { self.books = booksList }
        }
    }
}
