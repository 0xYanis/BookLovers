//
//  Book.swift
//  BookLovers
//
//  Created by Yanis on 23.03.2024.
//

import Foundation

struct Book: Identifiable {
    let id: String
    let title: String
    let description: String
    let publisher: String
    let publishedDate: String
    let pages: Int
    let smallImage: URL?
    let bigImage: URL?
    let previewLink: URL?
    let pdf: URL?
    let genre: LiteraryGenre?
    
    var categories: String { self.categoriesArray.joined(separator: " · ") }
    var authors: String { self.authorsArray.joined(separator: ", ") }
    
    private var authorsArray: [String]
    private var categoriesArray: [String]
}

// MARK: - DTO to Book

extension Book {
    init(dto: DTOBook) {
        self.id = dto.id
        self.title = dto.bookInfo.title ?? ""
        self.authorsArray = dto.bookInfo.authors ?? []
        self.description = dto.bookInfo.description ?? ""
        self.pages = dto.bookInfo.pageCount ?? 0
        self.smallImage = URL(string: "https" + (dto.bookInfo.imageLinks?.smallThumbnail?.dropFirst(4) ?? ""))
        self.bigImage = URL(string: "https" + (dto.bookInfo.imageLinks?.thumbnail?.dropFirst(4) ?? ""))
        self.previewLink = URL(string: dto.bookInfo.previewLink ?? "")
        self.pdf = URL(string: dto.accessInfo.pdf.acsTokenLink ?? "")
        self.genre = LiteraryGenre(rawValue: dto.bookInfo.categories?.first ?? "")
        self.categoriesArray = dto.bookInfo.categories ?? []
        self.publisher = dto.bookInfo.publisher ?? ""
        self.publishedDate = Book.dateConverter(string: dto.bookInfo.publishedDate)
    }
    
    static func dateConverter(string: String?) -> String {
        guard let string else { return "" }
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if string.count == 4 { return string }

        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateStyle = .medium
            let converted = dateFormatter.string(from: date)
            return converted
        } else {
            return string
        }
    }
}

extension [DTOBook] {
    var converted: [Book] {
        let books = self.compactMap { Book(dto: $0) }
        return books
    }
}

// MARK: - SwiftUI Preview

extension Book {
    static var preview: Book {
        .init(
            id: "0",
            title: "Title of the book",
            description: "",
            publisher: "",
            publishedDate: "",
            pages: 0,
            smallImage: nil,
            bigImage: nil,
            previewLink: nil,
            pdf: nil,
            genre: nil,
            authorsArray: [],
            categoriesArray: []
        )
    }
}
