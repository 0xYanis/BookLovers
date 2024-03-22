//
//  FavoriteBook.swift
//  BookLovers
//
//  Created by Yanis on 20.03.2024.
//

import Foundation

struct FavoriteBook: Identifiable {
    let id = UUID().uuidString
    let image: String = "book1"
    let title: String
    let author: String
    let description: String? = nil
    var currentPage: Int = 0
    let pages: Int
    let link: URL?
    var type: FavoriteType
    
    var percent: Int {
        max((currentPage * 100) / pages, 0)
    }
}

// MARK: - SwiftUI mock data

extension FavoriteBook {
    static let preview: [FavoriteBook] = [
        .init(title: "The Alchemist", author: "Pauloelho", currentPage: 20, pages: 150, link: nil, type: .readingList),
        .init(title: "1984", author: "George Orwell", currentPage: 30, pages: 400, link: nil, type: .readingList),
        .init(title: "To Kill a Mockingbird", author: "Harper Lee", currentPage: 5, pages: 280, link: nil, type: .archived),
        .init(title: "The Greatatsby", author: ". Scott Fitzgerald", currentPage: 10, pages: 250, link: nil, type: .onReading),
        .init(title: "Brave New World", author: "Aldous Huxley", currentPage: 50, pages: 320, link: nil, type: .archived),
        .init(title: "The Catcher in the R", author: "J.D. Salinger", currentPage: 8, pages: 230, link: nil, type: .readingList)
    ]
}
