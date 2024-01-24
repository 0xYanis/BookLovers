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
            switch await booksProvider.getBooks() {
            case .success(let books):
                await MainActor.run { self.books = books.items }
            case .failure(let error):
                await MainActor.run { print(error) }
            }
        }
    }
}
