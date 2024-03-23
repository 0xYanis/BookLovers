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
    
    static var mockPreview: Book {
        .init(id: "1", title: "", description: "", pages: 0, smallImage: nil, bigImage: nil, previewLink: nil, pdf: nil, genre: nil, authorsArray: [])
    }
}

extension Book {
    init(dto: DTOBook) {
        self.id = dto.id
        self.title = dto.bookInfo.title
        self.authorsArray = dto.bookInfo.authors
        self.description = dto.bookInfo.description ?? ""
        self.pages = dto.bookInfo.pageCount
        self.smallImage = URL(string: dto.bookInfo.imageLinks.smallThumbnail)
        self.bigImage = URL(string: dto.bookInfo.imageLinks.thumbnail)
        self.previewLink = URL(string: dto.bookInfo.previewLink)
        self.pdf = URL(string: dto.accessInfo.pdf.acsTokenLink ?? "")
        self.genre = LiteraryGenre(rawValue: dto.bookInfo.categories?.first ?? "")
    }
}
