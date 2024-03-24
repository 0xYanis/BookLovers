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
    let pages: Int
    let smallImage: URL?
    let bigImage: URL?
    let previewLink: URL?
    let pdf: URL?
    let genre: LiteraryGenre?
    var authors: String {
        self.authorsArray.joined(separator: ", ")
    }
    
    private var authorsArray: [String]
}

extension Book {
    init(dto: DTOBook) {
        self.id = dto.id
        self.title = dto.bookInfo.title ?? ""
        self.authorsArray = dto.bookInfo.authors ?? []
        self.description = dto.bookInfo.description ?? ""
        self.pages = dto.bookInfo.pageCount ?? 0
        self.smallImage = URL(string: "https" + (dto.bookInfo.imageLinks.smallThumbnail?.dropFirst(4) ?? ""))
        self.bigImage = URL(string: "https" + (dto.bookInfo.imageLinks.thumbnail?.dropFirst(4) ?? ""))
        self.previewLink = URL(string: dto.bookInfo.previewLink ?? "")
        self.pdf = URL(string: dto.accessInfo.pdf.acsTokenLink ?? "")
        self.genre = LiteraryGenre(rawValue: dto.bookInfo.categories?.first ?? "")
    }
}

extension [DTOBook] {
    var converted: [Book] {
        let books = self.compactMap { Book(dto: $0) }
        return books
    }
}

extension Book {
    static var preview: Book {
        .init(
            id: "1",
            title: "The master and Margarita",
            description: "lOREM Ipsym is a dummy text..",
            pages: 82,
            smallImage: URL(string: "https://books.google.com/books/content?id=j5H4zgEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
            bigImage: URL(string: "https://books.google.com/books/content?id=j5H4zgEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
            previewLink: nil,
            pdf: nil,
            genre: nil,
            authorsArray: ["Yanis, miyagis"]
        )
    }
}
